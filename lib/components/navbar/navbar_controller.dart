import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavbarController extends GetxController {
  RxList<IconData?> icons = <IconData?>[].obs;
  RxList<String?> assetPaths = <String?>[].obs;
  RxList<Color> colors = <Color>[].obs;
  RxDouble navbarHeight = 80.0.obs;
  RxDouble navItemSize = 40.0.obs;
  RxDouble iconSize = 24.0.obs;
  RxInt selectedIndex = 0.obs;

  void initializeNavbar({
    List<IconData?>? iconsList,
    List<String?>? assetPathsList,
    required List<Color> colorsList,
    double navbarHeight = 80.0,
    double navItemSize = 40.0,
    double iconSize = 24.0,
  }) {
    icons.value = iconsList ?? [];
    assetPaths.value = assetPathsList ?? [];
    colors.value = colorsList;
    this.navbarHeight.value = navbarHeight;
    this.navItemSize.value = navItemSize;
    this.iconSize.value = iconSize;
    selectedIndex.value = 0;
  }

  // Switch tabs
  void switchTab(int index) {
    selectedIndex.value = index;
  }
}
