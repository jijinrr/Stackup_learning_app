import 'package:get/get.dart';
import 'package:stackup/View/home/home_screen.dart';

class HomeController extends GetxController {
  final RxList<Course> courses = <Course>[].obs;
  final RxString username = 'John Doe'.obs;

  @override
  void onInit() {
    super.onInit();
    // Simulate loading courses
    courses.addAll([
      Course(
        title: 'Flutter Development',
        description: 'Learn to build beautiful mobile apps',
        imageUrl: 'assets/flutter.png',
        lessonsCount: 24,
        progress: 0.6,
      ),
      Course(
        title: 'UI/UX Design',
        description: 'Master the art of user interface design',
        imageUrl: 'assets/design.png',
        lessonsCount: 18,
        progress: 0.3,
      ),
      Course(
        title: 'Web Development',
        description: 'Build modern responsive websites',
        imageUrl: 'assets/web.png',
        lessonsCount: 32,
        progress: 0.8,
      ),
    ]);
  }
}
