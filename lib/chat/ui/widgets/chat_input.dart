import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final Function(String) onSubmit;
  final VoidCallback? onAttachmentPressed;
  final TextEditingController controller = TextEditingController();

  ChatInput({
    required this.onSubmit,
    this.onAttachmentPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          if (onAttachmentPressed != null)
            IconButton(
              icon: Icon(Icons.attachment),
              onPressed: onAttachmentPressed,
            ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                onSubmit(controller.text);
                controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
