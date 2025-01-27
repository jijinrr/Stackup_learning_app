import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:stackup/helper/my_colors.dart';

import 'dart:async';

import 'package:stackup/widgets/custom_snackbar.dart';

class UserLocationController extends GetxController {
  final String allowedIpAddress;

  UserLocationController(this.allowedIpAddress);

  final NetworkInfo _networkInfo = NetworkInfo();
  RxString currentIp = ''.obs;
  Rx<DateTime?> checkInTime = Rx<DateTime?>(null);
  Rx<DateTime?> checkOutTime = Rx<DateTime?>(null);
  RxString status = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isCheckedIn = false.obs; // Track check-in status
  RxString elapsedTime = '00:00:00'.obs;

  Timer? _timer;

  Future<void> getCurrentIp(BuildContext context) async {
    isLoading.value = true;
    try {
      final wifiIp = await _networkInfo.getWifiIP();
      currentIp.value = wifiIp ?? 'Unknown';
    } catch (e) {
      CustomSnackBar.show(context,
          comment: "Error getting IP address: $e",
          backgroundColor: MyColors.red);
      status.value = 'Error getting IP address: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handleCheckIn(BuildContext context) async {
    await getCurrentIp(context);

    if (currentIp.value == allowedIpAddress) {
      if (isCheckedIn.value) {
        // User is already checked in
        status.value = 'Already checked in. Please check out first.';
        CustomSnackBar.show(context,
            comment: "Already checked in. Please check out first.",
            backgroundColor: MyColors.red);

        return;
      }

      checkInTime.value = DateTime.now();
      CustomSnackBar.show(context,
          comment: "Successfully checked in", backgroundColor: MyColors.green1);

      status.value = 'Successfully checked in';
      isCheckedIn.value = true;
      startTrackingTime();
    } else {
      status.value = 'Error: IP address does not match allowed address';
      CustomSnackBar.show(context,
          comment: "Error: IP address does not match allowed address",
          backgroundColor: MyColors.red);
    }
  }

  Future<void> handleCheckOut(BuildContext context) async {
    await getCurrentIp(context);

    if (currentIp.value == allowedIpAddress) {
      if (!isCheckedIn.value) {
        // User is not checked in
        status.value = 'Please check in first before checking out.';
        CustomSnackBar.show(context,
            comment: "Please check in first before checking out.",
            backgroundColor: MyColors.red);

        return;
      }
      CustomSnackBar.show(context,
          comment: "Successfully checked out",
          backgroundColor: MyColors.green1);

      checkOutTime.value = DateTime.now();
      status.value = 'Successfully checked out';
      isCheckedIn.value = false;
      stopTrackingTime();
    } else {
      status.value = 'Error: IP address does not match allowed address';
      CustomSnackBar.show(context,
          comment: "'Error: IP address does not match allowed address'",
          backgroundColor: MyColors.red);
    }
  }

  String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'Not set';
    return DateFormat('dd MMM yyyy - hh:mm a').format(dateTime);
  }

  void startTrackingTime() {
    stopTrackingTime();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (checkInTime.value != null) {
        final elapsed = DateTime.now().difference(checkInTime.value!);
        elapsedTime.value = _formatDuration(elapsed);
      }
    });
  }

  void stopTrackingTime() {
    _timer?.cancel();
    elapsedTime.value = '00:00:00';
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  @override
  void onClose() {
    stopTrackingTime();
    super.onClose();
  }
}
