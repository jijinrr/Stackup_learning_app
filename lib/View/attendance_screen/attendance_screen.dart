import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stackup/View/attendance_screen/controller/attendance_controller.dart';
import 'package:stackup/helper/my_colors.dart';
import 'package:stackup/widgets/custom_appbar.dart';
import 'package:stackup/widgets/loading_screen.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceController attendanceController =
        Get.find<AttendanceController>();

    return Scaffold(
      appBar: CustomAppBar(
        notification: true,
        title: 'Attendance',
        leadingOnPressed: () {
          Get.back();
        },
      ),
      body: Container(
        color: MyColors.white,
        child: Obx(() {
          final attendanceList = attendanceController
                  .attendanceModel.value.attendance?.first.attendance ??
              [];

          if (attendanceList.isEmpty) {
            return const Center(
              child: Text(
                'No attendance records found',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return attendanceController.isLoading.value
              ? LoadingScreen()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: attendanceList.length,
                  itemBuilder: (context, index) {
                    final attendance = attendanceList[index];
                    final date = attendance.date != null
                        ? DateFormat('EEE, MMM d, yyyy')
                            .format(DateTime.parse(attendance.date!))
                        : 'Date not available';

                    final checkIn = attendance.checkIn != null
                        ? DateFormat('h:mm a')
                            .format(DateTime.parse(attendance.checkIn!))
                        : '--:--';

                    final checkOut = attendance.checkOut != null
                        ? DateFormat('h:mm a')
                            .format(DateTime.parse(attendance.checkOut!))
                        : '--:--';

                    final hoursWorked =
                        attendance.hoursWorked?.toStringAsFixed(1) ?? '0.0';

                    // Determine status color based on hours worked
                    Color statusColor = MyColors.primaryColor;
                    if (attendance.hoursWorked != null) {
                      if (attendance.hoursWorked! < 6) {
                        statusColor = Colors.red;
                      } else if (attendance.hoursWorked! < 8) {
                        statusColor = Colors.orange;
                      } else {
                        statusColor = Colors.green;
                      }
                    }

                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: statusColor, width: 1.5),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.1),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  date,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _buildInfoColumn(
                                      'Check In',
                                      checkIn,
                                      Icons.login,
                                      Colors.blue,
                                    ),
                                  ),
                                  Container(
                                    height: 60,
                                    width: 1,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  Expanded(
                                    child: _buildInfoColumn(
                                      'Check Out',
                                      checkOut,
                                      Icons.logout,
                                      Colors.purple,
                                    ),
                                  ),
                                  Container(
                                    height: 60,
                                    width: 1,
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  Expanded(
                                    child: _buildInfoColumn(
                                      'Hours',
                                      '$hoursWorked hrs',
                                      Icons.access_time_filled,
                                      statusColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        }),
      ),
    );
  }

  Widget _buildInfoColumn(
      String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
