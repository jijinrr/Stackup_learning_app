import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackup/View/course_screen/controller/courses_controller.dart';
import 'package:stackup/View/course_screen/detail_level_screen.dart';
import 'package:stackup/helper/my_colors.dart';
import 'package:stackup/widgets/custom_appbar.dart';
import 'package:stackup/widgets/loading_screen.dart';

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CoursesController coursesController = Get.find<CoursesController>();

    var course = coursesController.coursesModel.value.courses?.first.courses;
    var levelList;

    if (coursesController.selecteCourse.value == 'Flutter') {
      levelList = course?[coursesController.selectIndex.value].flutter?.levels;
    } else if (coursesController.selecteCourse.value == 'Mean') {
      levelList = course?[coursesController.selectIndex.value].mean?.levels;
    } else {
      levelList = course?[coursesController.selectIndex.value].uiUx?.levels;
    }

    return Scaffold(
      backgroundColor: MyColors.white.withOpacity(0.9),
      appBar: CustomAppBar(
        title: coursesController.selecteCourse.value,
        notification: false,
        leadingOnPressed: () {
          Get.back();
        },
      ),
      body: coursesController.isLoading.value
          ? LoadingScreen()
          : ListView.builder(
              itemCount: levelList?.length ?? 0,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                var levels = levelList?[index].level;
                var name = levelList?[index].name;
                // final level = levels[index];
                return GestureDetector(
                  onTap: () {
                    // print(levelList);
                    // print(courseNames?.flutter.levels);
                    Get.to(DetailLevelScreen());
                    coursesController.selectLevelIndex.value = index;
                  },
                  child: Card(
                    color: MyColors.white,
                    // elevation: 2,
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
                                levels ?? '',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.blue,
                                ),
                              ),
                              // Container(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 12, vertical: 4),
                              //   decoration: BoxDecoration(
                              //     color: Colors.red.shade50,
                              //     borderRadius: BorderRadius.circular(12),
                              //     border: Border.all(color: Colors.red.shade200),
                              //   ),
                              //   child: Text(
                              //     ' level.difficulty',
                              //     style: TextStyle(
                              //       fontSize: 12,
                              //       color: Colors.red.shade700,
                              //       fontWeight: FontWeight.w500,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            name ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 16),
                          LinearProgressIndicator(
                            value: 0.2,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                MyColors.deepPurple),
                          ),
                          const SizedBox(height: 8),
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
