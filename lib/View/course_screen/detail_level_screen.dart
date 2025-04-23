import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackup/View/course_screen/controller/courses_controller.dart';
import 'package:stackup/helper/my_colors.dart';
import 'package:stackup/widgets/custom_appbar.dart';

class DetailLevelScreen extends StatelessWidget {
  const DetailLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CoursesController coursesController = Get.find<CoursesController>();
    final course = coursesController.coursesModel.value.courses?.first.courses;
    List<dynamic>? levelList;

    if (coursesController.selecteCourse.value == 'Flutter') {
      levelList = course?[coursesController.selectIndex.value].flutter?.levels;
    } else if (coursesController.selecteCourse.value == 'Mean') {
      levelList = course?[coursesController.selectIndex.value].mean?.levels;
    } else {
      levelList = course?[coursesController.selectIndex.value].uiUx?.levels;
    }

    final topics =
        levelList?[coursesController.selectLevelIndex.value].topics ?? [];

    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: CustomAppBar(
        title: 'Level ${coursesController.selectLevelIndex.value + 1}',
        notification: false,
        leadingOnPressed: () => Get.back(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Topics',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: MyColors.blue,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: topics.length,
                      itemBuilder: (context, topicIndex) {
                        final topic = topics[topicIndex];
                        return Card(
                          color: MyColors.white,
                          margin: const EdgeInsets.only(bottom: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  topic.name ?? '',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.blue,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // LinearProgressIndicator(
                                //   value: 0.2,
                                //   backgroundColor: Colors.grey.shade200,
                                //   valueColor: AlwaysStoppedAnimation<Color>(
                                //       MyColors.deepPurple),
                                // ),
                                // const SizedBox(height: 16),
                                // Subtopics list
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: topic.subtopics?.length ?? 0,
                                  itemBuilder: (context, subIndex) {
                                    final subtopic = topic.subtopics[subIndex];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: Text(
                                        '• $subtopic',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
