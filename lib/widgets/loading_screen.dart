import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: LoadingAnimationWidget.hexagonDots(
          color: Colors.red,
          size: 40,
        ),
      ),
    );
  }
}
