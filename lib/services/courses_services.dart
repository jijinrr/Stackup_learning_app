import 'dart:developer';
import 'package:get/get_connect/connect.dart';
import 'package:stackup/model/courses_model.dart';

class CoursesServices extends GetConnect {
  Future<CoursesModel?> fetchCoursesService() async {
    try {
      final response = await get(
        'http://localhost:8000/api/user/courses',
      ); // Android emulator localhost
      // print(response.body.toString());

      if (response.statusCode == 200 && response.body != null) {
        return CoursesModel.fromJson(response.body);
      } else {
        log('Failed to fetch UsersServices: ${response.statusText}');
        return null;
      }
    } catch (e) {
      log('Error fetching UsersServices: $e');
      return null;
    }
  }
}
