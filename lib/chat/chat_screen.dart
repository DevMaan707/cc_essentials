import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/chat_controller.dart';
import 'models/chat_message.dart';
import 'ui/widgets/typing_indicator.dart';
import 'ui/widgets/message_widget.dart';
import 'ui/widgets/chat_input.dart';
import 'utils/file_picker.dart';

class ChatScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.find();

    // Add scroll listener for pagination
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        chatController.loadMoreMessages();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: chatController.resetChat,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              _scrollToBottom(); // Auto scroll when messages change
              return ListView.builder(
                controller: _scrollController,
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final message = chatController.messages[index];
                  return MessageWidget(
                    message: message,
                    config: chatController.config,
                  );
                },
              );
            }),
          ),
          Obx(() =>
              chatController.isTyping.value ? TypingIndicator() : SizedBox()),
          ChatInput(
            onSubmit: (text) => chatController.handleUserResponse(text),
            onAttachmentPressed: () async {
              final filePath = await pickFile();
              if (filePath != null) {
                await chatController.handleUserResponse(
                  'Sent an attachment',
                  contentType: MessageContentType.file,
                  mediaUrl: filePath,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
