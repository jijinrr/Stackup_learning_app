import 'package:get/get.dart';
import 'package:stackup/View/attendance_screen/controller/attendance_controller.dart';
import 'package:stackup/View/edit_profile/controller/edit_profile_controller.dart';
import 'package:stackup/View/home/controller/home_controller.dart';
import 'package:stackup/View/notifications_screen/controller/notifications_controller.dart';
import 'package:stackup/controller/auth_controller.dart';
import 'package:stackup/controller/bottom_nav_controller.dart';
import 'package:stackup/View/course_screen/controller/courses_controller.dart';
import 'package:stackup/controller/theme_controller.dart';
import 'package:stackup/controller/user_info_controller.dart';
import 'package:stackup/controller/user_location_controller.dart';
import 'package:stackup/controller/users_controller.dart';

class StoreBinding implements Bindings {
  //! for lazyloading the controllers inorder to optimize the memory usage
  //! and avoid innecessary memory usage in the device
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => BottomNavController(), fenix: true);
    Get.lazyPut(() => UsersController(), fenix: true);
    Get.lazyPut(() => UserInfoController(), fenix: true);
    Get.lazyPut(() => CoursesController(), fenix: true);
    Get.lazyPut(() => AttendanceController(), fenix: true);
    Get.lazyPut(() => NotificationsController(), fenix: true);
    Get.lazyPut(() => ThemeController(), fenix: true);
    Get.lazyPut(() => UserLocationController('192.168.12.146'), fenix: true);
  }
}
