import 'package:flutter/material.dart';

IconData getCourseIcon(String courseName) {
  switch (courseName.toLowerCase()) {
    case 'flutter':
      return Icons.flutter_dash;
    case 'react':
      return Icons.code;
    case 'python':
      return Icons.language;
    case 'javascript':
      return Icons.javascript;
    default:
      return Icons.school;
  }
}
