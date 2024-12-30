import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReactiveDropdown extends StatelessWidget {
  final RxInt selectedIndex;
  final List<Widget> items;
  final Color? dropdownColor;
  final double borderRadius;
  final TextStyle? textStyle;

  final double? width;
  final double? height;

  const ReactiveDropdown({
    super.key,
    required this.selectedIndex,
    required this.items,
    this.dropdownColor,
    this.borderRadius = 12.0,
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
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: selectedIndex.value,
            isExpanded: true,
            items: List.generate(
              items.length,
              (index) => DropdownMenuItem<int>(
                value: index,
                child: items[index],
              ),
            ),
            onChanged: (value) {
              if (value != null) {
                selectedIndex.value = value;
              }
            },
            dropdownColor: dropdownColor ?? Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            icon: const Icon(Icons.arrow_drop_down),
          ),
        ),
      );
    });
  }
}
