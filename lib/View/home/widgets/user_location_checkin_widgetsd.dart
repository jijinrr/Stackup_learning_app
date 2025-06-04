import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackup/controller/user_location_controller.dart';
import 'package:stackup/helper/buttons.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Card(
          color: MyColors.white.withOpacity(0.9),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Have a productive day!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Obx(() => Text(
                    'Current IP: ${controller.currentIp.value.isEmpty ? 'Unknown' : controller.currentIp.value}',
                    style: TextStyle(color: MyColors.green))),
                const SizedBox(height: 14),
                // Obx(() => Text(
                //       'Check-in Time: ${controller.formatDateTime(controller.checkInTime.value)}',
                //       style: Theme.of(context).textTheme.bodyMedium,
                //     )),

                // const SizedBox(height: 8),
                // Obx(() => Text(
                //       'Check-out Time: ${controller.formatDateTime(controller.checkOutTime.value)}',
                //       style: Theme.of(context).textTheme.bodyMedium,
                //     )),
                // const SizedBox(height: 16),
                Obx(() => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() => Text(
                              controller.elapsedTime.value,
                              style: Theme.of(context).textTheme.displaySmall,
                            )),
                        Buttons().borderedButton(
                          onTap: () {
                            if (!controller.isLoading.value) {
                              if (controller.isCheckedIn.value) {
                                controller.handleCheckOut(context);
                              } else {
                                controller.handleCheckIn(context);
                              }
                            }
                          },
                          text: controller.isCheckedIn.value
                              ? "Check Out"
                              : "Check In",
                          borderColor: controller.isCheckedIn.value
                              ? Colors.red
                              : MyColors.green1,
                          textColor: controller.isCheckedIn.value
                              ? Colors.red
                              : MyColors.green1,
                        ),
                      ],
                    )),
                // Obx(() => Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         Buttons().borderedButton(
                //             onTap: () {
                //               controller.isLoading.value
                //                   ? null
                //                   : controller.handleCheckIn;
                //             },
                //             text: "Check In : Check Out",
                //             borderColor: MyColors.green1,
                //             textColor: MyColors.green1),
                //         ElevatedButton(
                //             onPressed: controller.isLoading.value
                //                 ? null
                //                 : controller.handleCheckIn,
                //             child: Text('Check In')),
                //         ElevatedButton(
                //           onPressed: controller.isLoading.value
                //               ? null
                //               : controller.handleCheckOut,
                //           child: const Text('Check Out'),
                //         ),
                //       ],
                //     )),

                // const SizedBox(height: 16),
                // Obx(() => controller.status.value.isNotEmpty
                //     ? Text(
                //         controller.status.value,
                //         style: TextStyle(
                //           color: controller.status.value.contains('Error')
                //               ? Colors.red
                //               : Colors.green,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       )
                //     : const SizedBox.shrink()),
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
