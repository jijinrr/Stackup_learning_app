import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:stackup/View/home/home_screen.dart';

class BottomNavController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxString currentPlan = ''.obs;
  final RxString currentPlanId = ''.obs;
  final RxBool isExpanded = false.obs;

  final List<Widget> screens = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  void changeTab(int index) {
    if (index != 2) {
      currentIndex.value = index;
    }
    isExpanded.value = false;
  }

  void selectPlan(String plan, String planId, String providerType) {
    currentPlan.value = plan;
    currentPlanId.value = planId;

    isExpanded.value = false;
  }

  void toggleExpanded() async {
    if (isExpanded.value) {
      // Delay the collapse to allow the opacity animation to complete
      await Future.delayed(const Duration(milliseconds: 300));
    }
    isExpanded.value = !isExpanded.value;
  }
}
