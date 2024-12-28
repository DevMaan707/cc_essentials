import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'navbar_controller.dart';

class Navbar extends StatelessWidget {
  final NavbarController controller = Get.find<NavbarController>();

  Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        height: controller.navbarHeight.value,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(controller.icons.length, (index) {
            return _buildNavItem(index);
          }),
        ),
      );
    });
  }

  Widget _buildNavItem(int index) {
    bool isSelected = controller.selectedIndex.value == index;

    return GestureDetector(
      onTap: () {
        controller.switchTab(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: controller.navItemSize.value,
        height: controller.navItemSize.value,
        decoration: BoxDecoration(
          color: isSelected ? controller.colors[index] : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: controller.assetPaths[index] != null
            ? Image.asset(
                controller.assetPaths[index]!,
                width: controller.iconSize.value,
                height: controller.iconSize.value,
                color: isSelected ? Colors.white : Colors.black,
              )
            : Icon(
                controller.icons[index],
                size: controller.iconSize.value,
                color: isSelected ? Colors.white : Colors.black,
              ),
      ),
    );
  }
}
// void main() {
//   final NavbarController navbarController = Get.put(NavbarController());
//
//   navbarController.initializeNavbar(
//     iconsList: [null, null, Icons.account_balance_wallet_outlined, null, null], // Null if using assets
//     assetPathsList: [
//       'assets/icons/home.png', // Parent project asset
//       'assets/icons/bike.png', // Parent project asset
//       null,                    // Use built-in icon instead
//       'assets/icons/friends.png',
//       'assets/icons/profile.png',
//     ],
//     colorsList: [
//       Colors.blue,
//       Colors.green,
//       Colors.orange,
//       Colors.purple,
//       Colors.red,
//     ],
//     navbarHeight: 100.0,
//     navItemSize: 50.0,
//     iconSize: 28.0,
//   );
//
//   runApp(MyApp());
// }
