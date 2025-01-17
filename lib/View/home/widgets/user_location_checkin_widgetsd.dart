import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackup/controller/user_location_controller.dart';
import 'package:stackup/helper/my_colors.dart';

class UserLocationScreen extends StatelessWidget {
  final String allowedIpAddress;

  const UserLocationScreen({super.key, required this.allowedIpAddress});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final controller = Get.put(UserLocationController(allowedIpAddress));

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: MyColors.white.withOpacity(0.7),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => Text(
                      'Current IP: ${controller.currentIp.value.isEmpty ? 'Unknown' : controller.currentIp.value}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
                const SizedBox(height: 16),
                Obx(() => Text(
                      'Check-in Time: ${controller.formatDateTime(controller.checkInTime.value)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                const SizedBox(height: 8),
                Obx(() => Text(
                      'Check-out Time: ${controller.formatDateTime(controller.checkOutTime.value)}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                const SizedBox(height: 16),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.handleCheckIn,
                          child: const Text('Check In'),
                        ),
                        ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.handleCheckOut,
                          child: const Text('Check Out'),
                        ),
                      ],
                    )),
                const SizedBox(height: 16),
                Obx(() => controller.status.value.isNotEmpty
                    ? Text(
                        controller.status.value,
                        style: TextStyle(
                          color: controller.status.value.contains('Error')
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const SizedBox.shrink()),
                Obx(() => controller.isLoading.value
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      )
                    : const SizedBox.shrink()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
