import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:stackup/controller/user_info_controller.dart';
import 'package:stackup/routes/app_routes.dart';
import 'package:stackup/utils/sharedpreference.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      SharedPrefs.savePlan('email', email.trim());
      final UserInfoController userInfoController =
          Get.find<UserInfoController>();
      userInfoController.fetchuserInfo();
      Get.offAllNamed(RouteNames.homeScreen);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      SharedPrefs.savePlan('email', email.trim());
// !SharedPrefs.getString('email') ?? '';
      final UserInfoController userInfoController =
          Get.find<UserInfoController>();
      userInfoController.fetchuserInfo();
      Get.offAllNamed(RouteNames.homeScreen);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAllNamed(RouteNames.loginScreen);
  }
}
