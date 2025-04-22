import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:stackup/View/attendance_screen/model/attendance_model.dart';
import 'package:stackup/dio_interceptor/dio_interceptor.dart';

class AttendanceServices {
  static final Dio _dio = ApiClient.getDio();

  Future<AttendanceModel?> fetchAttendanceService() async {
    try {
      final response = await _dio
          .get('http://localhost:8000/api/user/getAllAttendance', data: {
        "email": "john.smith@example.com"
      }); // Android emulator localhost

      // log(response.data.toString());

      if (response.statusCode == 200 && response.data != null) {
        log("======  AttendanceServices Succesfully =======");
        return AttendanceModel.fromJson(response.data);
      } else {
        log('Failed to fetch UserInfoServices: ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      log('Error fetching UserInfoServices: $e');
      return null;
    }
  }
}
