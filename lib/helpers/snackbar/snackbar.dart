import 'package:flutter/material.dart';

class AdvancedBubbleNotification {
  static void show(
    BuildContext context,
    String message, {
    required MessageType type,
    Duration duration = const Duration(seconds: 5),
  }) {
    final overlay = Navigator.of(context).overlay;
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => BubbleAnimation(
        message: message,
        type: type,
        onDismiss: () {
          overlayEntry.remove();
        },
      ),
    );

    overlay?.insert(overlayEntry);
    Future.delayed(duration, () {
      if (overlayEntry.mounted) overlayEntry.remove();
    });
  }
}

enum MessageType { success, error, info }

class BubbleAnimation extends StatefulWidget {
  final String message;
  final MessageType type;
  final VoidCallback onDismiss;

  const BubbleAnimation({
    required this.message,
    required this.type,
    required this.onDismiss,
    super.key,
  });

  @override
  BubbleAnimationState createState() => BubbleAnimationState();
}

class BubbleAnimationState extends State<BubbleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bubbleSize;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _bubbleSize = Tween<double>(begin: 40, end: 240).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: FadeTransition(
        opacity: _opacity,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final isExpanded = _bubbleSize.value > 60;
            return Center(
              child: GestureDetector(
                onTap: widget.onDismiss,
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: isExpanded ? 120 : 40,
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: isExpanded ? 16 : 0, vertical: 10),
                  decoration: BoxDecoration(
                    color: _getBackgroundColor(widget.type),
                    borderRadius: BorderRadius.circular(isExpanded ? 20 : 40),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _getIcon(widget.type),
                      if (isExpanded) ...[
                        const SizedBox(width: 10),
                        Text(
                          widget.message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getBackgroundColor(MessageType type) {
    switch (type) {
      case MessageType.success:
        return Colors.green;
      case MessageType.error:
        return Colors.red;
      case MessageType.info:
        return Colors.blue;
    }
  }

  Widget _getIcon(MessageType type) {
    IconData icon;
    switch (type) {
      case MessageType.success:
        icon = Icons.check_circle;
        break;
      case MessageType.error:
        icon = Icons.error;
        break;
      case MessageType.info:
        icon = Icons.info;
        break;
    }
    return Icon(icon, color: Colors.white);
  }
}
