import 'package:flutter/material.dart';

class LoadingDots extends StatefulWidget {
  @override
  _LoadingDotsState createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              height: 6,
              width: 6,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(
                  ((_controller.value + (index * 0.3)) % 1.0),
                ),
                shape: BoxShape.circle,
              ),
            );
          },
        );
      }),
    );
  }
}
