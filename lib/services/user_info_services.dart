import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:stackup/dio_interceptor/dio_interceptor.dart';
import 'package:stackup/model/user_info_model.dart';
import 'package:stackup/utils/sharedpreference.dart';

class UserInfoServices {
  static final Dio _dio = ApiClient.getDio();

  Future<UserInfoModel?> fetchUserInfoService() async {
    var email = SharedPrefs.getString('email') ?? '';
    try {
      final response = await _dio.get(
          'http://localhost:8000/api/stackup/userInfo',
          data: {"email": email}); // Android emulator localhost

      // log(response.data.toString());

      if (response.statusCode == 200 && response.data != null) {
        // print("======  UserInfoServices Succesfully =======");
        return UserInfoModel.fromJson(response.data);
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
