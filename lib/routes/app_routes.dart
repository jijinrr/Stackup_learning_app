import 'package:get/get.dart';
import 'package:stackup/View/home/home_screen.dart';
import 'package:stackup/View/login_screen/login_screen.dart';
import 'package:stackup/View/profile_screen/profile_screen.dart';
import 'package:stackup/View/sign_up_screen/sign_up_screen.dart';
import 'package:stackup/View/splash_screen/splash_screen.dart';
import 'package:stackup/View/students_dashboard.dart/students_dashboard.dart';

class AppRoutes {
  // pages corresponding to routnames
  static final pages = [
    GetPage(
      name: RouteNames.loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: RouteNames.homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(name: RouteNames.signUpScreen, page: () => SignUpScreen()),
    GetPage(name: RouteNames.splashScreen, page: () => SplashScreen()),
    GetPage(name: RouteNames.profileScreen, page: () => ProfileScreen()),
    GetPage(name: RouteNames.studentDashboard, page: () => StudentDashboard()),
  ];
}

// routnames of the pages used in the app
class RouteNames {
  static const homeScreen = "/home_screen";
  static const loginScreen = "/login_screen";
  static const splashScreen = "/splash_screen";
  static const signUpScreen = "/signup_screen";
  static const profileScreen = "/profile_screen";
  static const studentDashboard = "/student_dashboard";
}
