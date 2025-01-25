import 'package:flutter/material.dart';
import '../../models/chat_message.dart';
import '../../models/chat_config.dart';

class MessageWidget extends StatelessWidget {
  final ChatMessage message;
  final ChatConfig config;

  const MessageWidget({
    Key? key,
    required this.message,
    required this.config,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (message.type == MessageType.bot) {
      return config.customBotMessageWidget?.call(message) ??
          DefaultBotMessageWidget(message: message);
    }
    return config.customUserMessageWidget?.call(message) ??
        DefaultUserMessageWidget(message: message);
  }
}

class DefaultBotMessageWidget extends StatelessWidget {
  final ChatMessage message;

  const DefaultBotMessageWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Icon(Icons.android),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: _buildMessageContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageContent() {
    switch (message.contentType) {
      case MessageContentType.image:
        return Image.network(message.mediaUrl!);
      case MessageContentType.file:
        return Row(
          children: [
            Icon(Icons.attachment),
            SizedBox(width: 8),
            Text(message.message),
          ],
        );
      default:
        return Text(message.message);
    }
  }
}

class DefaultUserMessageWidget extends StatelessWidget {
  final ChatMessage message;

  const DefaultUserMessageWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: _buildMessageContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageContent() {
    switch (message.contentType) {
      case MessageContentType.image:
        return Image.network(message.mediaUrl!);
      case MessageContentType.file:
        return Row(
          children: [
            Icon(Icons.attachment),
            SizedBox(width: 8),
            Text(message.message),
          ],
        );
      default:
        return Text(message.message);
    }
  }
}
