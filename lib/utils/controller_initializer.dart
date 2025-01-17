import 'package:get/get.dart';
import 'package:stackup/View/home/controller/home_controller.dart';
import 'package:stackup/controller/auth_controller.dart';
import 'package:stackup/controller/user_location_controller.dart';

class StoreBinding implements Bindings {
  //! for lazyloading the controllers inorder to optimize the memory usage
  //! and avoid innecessary memory usage in the device
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => UserLocationController('192.168.1.8'), fenix: true);
  }
}
