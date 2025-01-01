import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReactiveDropdown extends StatelessWidget {
  final RxInt selectedIndex;
  final List<Widget> items;
  final Color? dropdownColor;
  final double? borderRadius;
  final TextStyle? textStyle;

  final double? width;
  final double? height;

  static const double _defaultBorderRadius = 12.0;
  static const Color _defaultBorderColor = Colors.grey;

  const ReactiveDropdown({
    super.key,
    required this.selectedIndex,
    required this.items,
    this.dropdownColor,
    this.borderRadius,
    this.textStyle,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(borderRadius ?? _defaultBorderRadius),
          border: Border.all(color: _defaultBorderColor),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: selectedIndex.value,
            isExpanded: true,
            items: List.generate(
              items.length,
              (index) => DropdownMenuItem<int>(
                value: index,
                child: DefaultTextStyle(
                  style: textStyle ?? Theme.of(context).textTheme.bodyMedium!,
                  child: items[index],
                ),
              ),
            ),
            onChanged: (value) {
              if (value != null) {
                selectedIndex.value = value;
              }
            },
            dropdownColor: dropdownColor ?? Theme.of(context).cardColor,
            borderRadius:
                BorderRadius.circular(borderRadius ?? _defaultBorderRadius),
            icon: Icon(
              Icons.arrow_drop_down,
              color: textStyle?.color ?? Theme.of(context).iconTheme.color,
            ),
          ),
        ),
      );
    });
  }
}
