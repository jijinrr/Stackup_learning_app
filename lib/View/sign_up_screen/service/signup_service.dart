import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:stackup/dio_interceptor/dio_interceptor.dart';
import 'package:stackup/model/user_info_model.dart';

class SignupService {
  static final Dio _dio = ApiClient.getDio();

  Future<UserInfoModel?> fetchUserInfoService({
    required String email,
    required String profileUrl,
    required String firstName,
    required String lastName,
    required int age,
    required String qualification,
    required String phoneNumber,
    required String selectedCourse,
    required String place,
    required String bio,
    required String progressLevel,
    required int coursePercentage,
    required String course,
    required int typingPercentage,
    required int englishPercentage,
    required int softSkillPercentage,
    required int speakingPercentage,
    required String gender,
  }) async {
    try {
      final response = await _dio.post(
        'http://localhost:8000/api/stackup/signup',
        data: {
          "email": email,
          "profileUrl": profileUrl,
          "firstName": firstName,
          "lastName": lastName,
          "age": age,
          "qualification": qualification,
          "phoneNumber": phoneNumber,
          "selectedCourse": selectedCourse,
          "place": place,
          "bio": bio,
          "progressLevel": progressLevel,
          "coursePercentage": coursePercentage,
          "course": course,
          "typingPercentage": typingPercentage,
          "englishPercentage": englishPercentage,
          "softSkillPercentage": softSkillPercentage,
          "speakingPercentage": speakingPercentage,
          "gender": gender,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        log("======  UserInfoServices Succesfully =======");
        log(response.data.toString());
        return UserInfoModel.fromJson(response.data);
      } else {
        log('Failed to fetch UserInfoServices: ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      log('Error fetching SignupService: $e');
      return null;
    }
  }
}
