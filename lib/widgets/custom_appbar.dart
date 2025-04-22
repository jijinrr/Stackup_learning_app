import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:stackup/helper/my_colors.dart';
import 'package:stackup/routes/app_routes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function()? leadingOnPressed;
  final bool notification;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leadingOnPressed,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyColors.primaryColor,
      leading: leadingOnPressed != null
          ? Platform.isIOS
              ? IconButton(
                  padding: const EdgeInsets.only(left: 10),
                  onPressed: leadingOnPressed,
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: MyColors.white,
                  ),
                )
              : IconButton(
                  padding: const EdgeInsets.only(left: 10),
                  onPressed: leadingOnPressed,
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: MyColors.white,
                  ),
                )
          : null,
      centerTitle: false,
      title: Text(
        title,
        style: TextStyle(
          color: MyColors.white,
          fontWeight: FontWeight.w600,
          fontSize: 22,
        ),
      ),
      actions: [
        notification
            ? IconButton(
                icon: Icon(
                  Remix.notification_2_fill,
                  color: MyColors.white,
                  size: 30,
                ),
                onPressed: () {
                  Get.toNamed(RouteNames.notificationScreen);
                },
              )
            : const SizedBox(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
