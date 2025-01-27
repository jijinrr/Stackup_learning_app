import 'package:flutter/material.dart';

class Buttons {
  /// Creates a fully customizable filled button.
  Widget filledButton({
    required String text,
    required VoidCallback onTap,
    Color backgroundColor = Colors.red,
    Color textColor = Colors.white,
    double radius = 12.0,
    double padding = 16.0,
    TextStyle? textStyle,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle ??
                TextStyle(
                  color: textColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }

  /// Creates a fully customizable bordered button.
  Widget borderedButton({
    required String text,
    required VoidCallback onTap,
    Color borderColor = Colors.red,
    Color textColor = Colors.red,
    double radius = 12.0,
    double padding = 16.0,
    TextStyle? textStyle,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle ??
                TextStyle(
                  color: textColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
