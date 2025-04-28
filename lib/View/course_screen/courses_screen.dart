import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackup/View/course_screen/course_list_screen.dart';
import 'package:stackup/View/course_screen/controller/courses_controller.dart';
import 'package:stackup/helper/icon_data.dart';
import 'package:stackup/helper/my_colors.dart';
import 'package:stackup/widgets/custom_appbar.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CoursesController coursesController = Get.find<CoursesController>();

    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CustomAppBar(
        title: "Courses",
        notification: false,
        leadingOnPressed: () {
          Get.back();
        },
      ),
      body: ListView.builder(
        itemCount: coursesController.courseList.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final bool isLocked = index == 1; // Example logic for locked courses
          final String courseName = coursesController.courseList[index];

          // This would normally come from your data model
          final String difficulty = isLocked ? "Intermediate" : "Beginner";
          final String description = isLocked
              ? "Complete the previous course to unlock this content."
              : "Learn the fundamentals and build your first application.";
          final int totalLessons = isLocked ? 12 : 8;
          final int completedLessons = isLocked ? 0 : 5;
          final double progressValue =
              isLocked ? 0.0 : completedLessons / totalLessons;

          return GestureDetector(
            onTap: () {
              if (!isLocked) {
                var selectedCourse = coursesController.courseList[index];
                coursesController.selectIndex.value = index;
                coursesController.selecteCourse.value = selectedCourse;
                Get.to(CourseListScreen());
              } else {
                // Show a message that course is locked
                Get.snackbar(
                  "Course Locked",
                  "Complete previous courses to unlock this content",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red.shade100,
                  colorText: Colors.red.shade900,
                );
              }
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Stack(
                children: [
                  Card(
                    color: MyColors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Course icon
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: isLocked
                                      ? Colors.grey.shade200
                                      : MyColors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  getCourseIcon(courseName),
                                  color: isLocked ? Colors.grey : MyColors.blue,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            courseName,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: isLocked
                                                  ? Colors.grey
                                                  : MyColors.blue,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: isLocked
                                                ? Colors.grey.shade100
                                                : Colors.red.shade50,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: isLocked
                                                  ? Colors.grey
                                                  : Colors.red,
                                            ),
                                          ),
                                          child: Text(
                                            difficulty,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: isLocked
                                                  ? Colors.grey.shade700
                                                  : Colors.red.shade700,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      description,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    isLocked ? "Progress locked" : "Progress",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                  Text(
                                    isLocked
                                        ? "0%"
                                        : "${(progressValue * 100).toInt()}%",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: isLocked
                                          ? Colors.grey.shade600
                                          : MyColors.deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: progressValue,
                                  backgroundColor: Colors.grey.shade200,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    isLocked
                                        ? Colors.grey.shade400
                                        : MyColors.deepPurple,
                                  ),
                                  minHeight: 8,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    isLocked
                                        ? "$totalLessons lessons"
                                        : "$completedLessons of $totalLessons lessons",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: isLocked
                                        ? null
                                        : () {
                                            if (!isLocked) {
                                              var selectedCourse =
                                                  coursesController
                                                      .courseList[index];
                                              coursesController
                                                  .selectIndex.value = index;
                                              coursesController.selecteCourse
                                                  .value = selectedCourse;
                                              Get.to(CourseListScreen());
                                            } else {
                                              Get.snackbar(
                                                "Course Locked",
                                                "Complete previous courses to unlock this content",
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                backgroundColor:
                                                    Colors.red.shade100,
                                                colorText: Colors.red.shade900,
                                              );
                                            }
                                          },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: MyColors.white,
                                      backgroundColor: isLocked
                                          ? Colors.grey.shade300
                                          : MyColors.green1,
                                      disabledForegroundColor:
                                          Colors.grey.shade400,
                                      disabledBackgroundColor:
                                          Colors.grey.shade200,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                    ),
                                    icon: Icon(
                                      isLocked
                                          ? Icons.lock
                                          : Icons.play_arrow_rounded,
                                      size: 16,
                                    ),
                                    label:
                                        Text(isLocked ? 'Locked' : 'Continue'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Overlay for locked courses
                  if (isLocked)
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                          child: Container(
                            color: Colors.black.withOpacity(0.05),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.lock_rounded,
                                      size: 36,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'Locked',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
