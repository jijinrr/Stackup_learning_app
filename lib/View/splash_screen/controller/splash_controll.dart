import 'package:get/get.dart';
import 'package:stackup/View/home/home_screen.dart';
import 'package:stackup/View/login_screen/login_screen.dart';
import 'package:stackup/utils/sharedpreference.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    // Add a 3-second delay
    await Future.delayed(const Duration(milliseconds: 2500));

    // Check user's logged-in status
    // bool isLoggedIn = _checkUserLoggedIn();

    var email = SharedPrefs.getString('email') ?? '';
    // Navigate to the appropriate screen
    if (email.isNotEmpty) {
      Get.offAll(() => HomeScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  // bool _checkUserLoggedIn() {
  //   // Replace this with your logic to check if the user is logged in
  //   return true; // Example: return true if user is logged in
  // }
}
