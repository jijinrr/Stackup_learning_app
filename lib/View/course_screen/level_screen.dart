import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackup/View/course_screen/course_list_screen.dart';
import 'package:stackup/View/course_screen/controller/courses_controller.dart';
import 'package:stackup/helper/my_colors.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CoursesController coursesController = Get.find<CoursesController>();

    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.red,
        title: Text(
          'Levels Activity',
          style: TextStyle(color: MyColors.white),
        ),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: coursesController.courseList.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          // final level = levels[index];
          return GestureDetector(
            onTap: () {
              var selectedCourse = coursesController.courseList[index];

              coursesController.selectIndex.value = index;
              coursesController.selecteCourse.value = selectedCourse;

              Get.to(CourseListScreen());
              // print(coursesController.courseList[index]);
              // print(courseNames?.flutter.levels);
            },
            child: Card(
              color: MyColors.white,
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                // side: BorderSide(color: Colors.red),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          coursesController.courseList[index],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: MyColors.blue,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Text(
                            ' level.difficulty',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ' level.description',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: 10,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ' lessons',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: MyColors.white,
                            backgroundColor: MyColors.green1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('Start'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
