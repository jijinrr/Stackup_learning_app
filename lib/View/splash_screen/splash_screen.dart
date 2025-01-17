import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:stackup/View/splash_screen/controller/splash_controll.dart';
import 'package:stackup/helper/my_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashController =
      Get.put(SplashController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
        backgroundColor: MyColors.red,
        body: Center(
          child: LoadingIndicator(
            indicatorType: Indicator.triangleSkewSpin,

            /// Required, The loading type of the widget
            colors: const [Colors.white],

            /// Optional, The color collections
            strokeWidth: 2,

            /// Optional, The stroke of the line, only applicable to widget which contains line
            // backgroundColor: Colors.black,

            /// Optional, Background of the widget
            // pathBackgroundColor: Colors.black

            /// Optional, the stroke backgroundColor
          ),
        )

        // Center(
        //     child: SvgPicture.asset(
        //   MyAssets.stackUp,
        //   // height: 24, // Consistent height for SVGs
        //   // width: 24, // Consistent width for SVGs
        //   color: MyColors.white,
        //   fit: BoxFit.scaleDown,
        // )),
        );
    return scaffold;
  }
}
