import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:stackup/controller/auth_controller.dart';
import 'package:stackup/dio_interceptor/dio_interceptor.dart';
import 'package:stackup/helper/my_colors.dart';
import 'package:stackup/routes/app_routes.dart';
import 'package:stackup/utils/controller_initializer.dart';
import 'package:stackup/utils/sharedpreference.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Get.put(AuthController()); // Initialize AuthController
  FlutterNativeSplash.remove();
  await SharedPrefs.init();
  ApiClient();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: StoreBinding(),
      initialRoute: RouteNames.splashScreen,
      debugShowCheckedModeBanner: false,
      title: 'stackup',
      theme: _lightTheme(),
      darkTheme: _darkTheme(),
      themeMode: ThemeMode.system, // Controlled by ThemeController
      getPages: AppRoutes.pages,
    );
  }

  ThemeData _lightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: MyColors.primaryColor,
        secondary: MyColors.secondaryColor,
        background: MyColors.lightgrey1,
        surface: MyColors.white,
        onPrimary: MyColors.white,
        onSecondary: MyColors.black,
        onBackground: MyColors.black,
        onSurface: MyColors.black,
        error: MyColors.red,
      ),
      scaffoldBackgroundColor: MyColors.lightgrey1,
      appBarTheme: AppBarTheme(
        backgroundColor: MyColors.primaryColor,
        foregroundColor: MyColors.white,
        elevation: 0,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: MyColors.black),
        bodyMedium: TextStyle(color: MyColors.darkgrey),
        headlineLarge: TextStyle(color: MyColors.primaryColor),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: MyColors.primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primaryColor,
          foregroundColor: MyColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.primaryColor),
        ),
        labelStyle: TextStyle(color: MyColors.darkgrey),
      ),
    );
  }

  ThemeData _darkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: MyColors.primaryColor,
        secondary: MyColors.greyOpacity,
        background: MyColors.boxColor1,
        surface: MyColors.boxColor,
        onPrimary: MyColors.white,
        onSecondary: MyColors.white,
        onBackground: MyColors.white,
        onSurface: MyColors.white,
        error: MyColors.red1,
      ),
      scaffoldBackgroundColor: MyColors.boxColor1,
      appBarTheme: AppBarTheme(
        backgroundColor: MyColors.boxColor,
        foregroundColor: MyColors.white,
        elevation: 0,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: MyColors.white),
        bodyMedium: TextStyle(color: MyColors.neutralGray),
        headlineLarge: TextStyle(color: MyColors.primaryColor),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: MyColors.primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primaryColor,
          foregroundColor: MyColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.greyOpacity),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.primaryColor),
        ),
        labelStyle: TextStyle(color: MyColors.neutralGray),
      ),
    );
  }
}
