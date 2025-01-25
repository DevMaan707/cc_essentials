import 'package:flutter/material.dart';

import 'loading_dots.dart';

class TypingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Text('Bot is typing'),
          SizedBox(width: 8),
          LoadingDots(), // Implement your loading animation
        ],
      ),
    );
  }
}
