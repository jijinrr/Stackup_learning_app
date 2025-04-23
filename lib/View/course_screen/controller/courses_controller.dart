import 'package:get/get.dart';
import 'package:stackup/model/courses_model.dart';
import 'package:stackup/services/courses_services.dart';

class CoursesController extends GetxController {
  RxInt selectIndex = 0.obs;
  RxInt selectLevelIndex = 0.obs;

  RxString selecteCourse = ''.obs;
  var coursesModel = CoursesModel().obs;
  var isLoading = false.obs;
  var courseList = ['Flutter', 'Mean', 'Ui/Ux'];

  @override
  void onInit() {
    super.onInit();
    fetchCourseInfo();
  }

  void fetchCourseInfo() async {
    isLoading.value = true;
    final course = await CoursesServices().fetchCoursesService();
    if (course != null) {
      coursesModel.value = course;
    }
    isLoading.value = false;
  }
}
