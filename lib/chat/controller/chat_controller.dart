import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/chat_config.dart';
import '../models/chat_message.dart';
import '../services/storage_service.dart';

class ChatController extends GetxController {
  final ChatConfig config;
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isTyping = false.obs;
  final RxBool isFirstInteraction = true.obs;
  final RxInt currentPage = 1.obs;
  final ChatStorageService _storageService = ChatStorageService();

  ChatController({required this.config});
  final List<String> _defaultResponses = [
    "I understand. Please tell me more.",
    "Interesting perspective. How else can I help you?",
    "Thank you for sharing that. What else would you like to discuss?",
    "I see. Is there anything specific you'd like to know?",
  ];
  int _defaultResponseIndex = 0;
  @override
  void onInit() {
    super.onInit();
    if (config.saveToLocal) {
      _loadSavedMessages();
    }
    initialize();
  }

  Future<void> _loadSavedMessages() async {
    try {
      final savedMessages = await _storageService.loadMessages();
      messages.addAll(savedMessages);
    } catch (e) {
      debugPrint('Error loading saved messages: $e');
    }
  }

  Future<void> initialize() async {
    isLoading.value = true;
    try {
      if (config.fetchQuestionFunction != null) {
        final question = await config.fetchQuestionFunction!();
        _addMessage(ChatMessage(
          message: question['message'],
          type: MessageType.bot,
        ));
      } else {
        _addMessage(ChatMessage(
          message: "Hello! How can I help you today?",
          type: MessageType.bot,
        ));
      }
    } catch (e) {
      _handleError('Failed to fetch initial question', e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handleUserResponse(String response,
      {MessageContentType contentType = MessageContentType.text,
      String? mediaUrl}) async {
    if (response.isEmpty && contentType == MessageContentType.text) return;

    final userMessage = ChatMessage(
      message: response,
      type: MessageType.user,
      contentType: contentType,
      mediaUrl: mediaUrl,
    );
    _addMessage(userMessage);

    isLoading.value = true;
    isTyping.value = true;

    try {
      if (isFirstInteraction.value && config.createChatFunction != null) {
        final createResult = await config.createChatFunction!(response);
        if (createResult != null) {
          isFirstInteraction.value = false;
        }
      }

      // Check if response matches any key in responses map
      String? nextQuestion;
      if (config.responses != null) {
        for (var key in config.responses!.keys) {
          if (response.toLowerCase().contains(key.toLowerCase())) {
            nextQuestion = config.responses![key];
            break;
          }
        }
      }

      if (config.answerFunction != null) {
        // If answer function exists, use it
        final answer = await config.answerFunction!(response);

        if (config.fetchQuestionFunction != null &&
            !(config.isConversationEnd?.call(answer) ?? false)) {
          final nextQ = await config.fetchQuestionFunction!();
          _addMessage(ChatMessage(
            message: nextQ['message'],
            type: MessageType.bot,
          ));
        }
      } else if (config.fetchQuestionFunction != null) {
        // If only fetchQuestion exists, just fetch next question
        final nextQ = await config.fetchQuestionFunction!();
        _addMessage(ChatMessage(
          message: nextQ['message'],
          type: MessageType.bot,
        ));
      } else {
        // Use default response or mapped response
        await Future.delayed(Duration(milliseconds: 500)); // Simulate delay
        _addMessage(ChatMessage(
          message: nextQuestion ?? _getDefaultResponse(),
          type: MessageType.bot,
        ));
      }
    } catch (e) {
      _handleError('Failed to process response', e);
    } finally {
      isLoading.value = false;
      isTyping.value = false;
    }
  }

  String _getDefaultResponse() {
    final response = _defaultResponses[_defaultResponseIndex];
    _defaultResponseIndex =
        (_defaultResponseIndex + 1) % _defaultResponses.length;
    return response;
  }

  void _addMessage(ChatMessage message) {
    messages.add(message);
    if (config.saveToLocal) {
      _storageService.saveMessages(messages);
    }
  }

  Future<void> loadMoreMessages() async {
    if (messages.length < currentPage.value * config.messagesPerPage) return;
    currentPage.value++;
    // Implement pagination logic here
  }

  void _handleError(String message, dynamic error) {
    debugPrint('$message: $error');
    _addMessage(ChatMessage(
      message: 'An error occurred. Please try again.',
      type: MessageType.bot,
      status: MessageStatus.error,
    ));
  }

  void resetChat() async {
    messages.clear();
    if (config.saveToLocal) {
      await _storageService.clearMessages();
    }
    isFirstInteraction.value = true;
    currentPage.value = 1;
    initialize();
  }
}
