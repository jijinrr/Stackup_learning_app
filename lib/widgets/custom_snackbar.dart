import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackup/helper/my_colors.dart';

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String comment,
    Color backgroundColor = Colors.blueGrey,
    Color textColor = Colors.white,
    IconData icon = Icons.comment,
    TextStyle? textStyle,
  }) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(icon, color: textColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              comment,
              style: textStyle ?? TextStyle(color: textColor),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showTopErrorMessage(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      icon: Icon(Icons.warning, color: MyColors.white),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }
}
