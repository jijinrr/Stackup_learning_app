import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:stackup/dio_interceptor/dio_interceptor.dart';
import 'package:stackup/model/user_info_model.dart';

class UserInfoServices {
  static final Dio _dio = ApiClient.getDio();

  Future<UserInfoModel?> fetchUserInfoService() async {
    try {
      final response = await _dio.get('http://localhost:8000/api/user/userInfo',
          data: {
            "email": "john.smith@example.com"
          }); // Android emulator localhost

      log(response.data.toString());

      if (response.statusCode == 200 && response.data != null) {
        return UserInfoModel.fromJson(response.data);
      } else {
        print('Failed to fetch UserInfoServices: ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      print('Error fetching UserInfoServices: $e');
      return null;
    }
  }
}
