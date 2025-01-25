import 'package:cc_essentials/chat/models/chat_message.dart';
import 'package:flutter/material.dart';

class ChatConfig {
  final Color primaryColor;
  final Color secondaryColor;
  final Widget Function(ChatMessage)? customBotMessageWidget;
  final Widget Function(ChatMessage)? customUserMessageWidget;
  final Future<dynamic> Function(String userResponse)?
      answerFunction; // Made optional
  final Future<dynamic> Function()? fetchQuestionFunction; // Made optional
  final Future<dynamic> Function(String firstResponse)? createChatFunction;
  final bool Function(dynamic response)? isConversationEnd; // Made optional
  final bool saveToLocal;
  final int messagesPerPage;
  final Map<String, String>? responses; // Added responses map

  ChatConfig({
    required this.primaryColor,
    required this.secondaryColor,
    this.customBotMessageWidget,
    this.customUserMessageWidget,
    this.answerFunction,
    this.fetchQuestionFunction,
    this.createChatFunction,
    this.isConversationEnd,
    this.saveToLocal = false,
    this.messagesPerPage = 20,
    this.responses,
  });
}
