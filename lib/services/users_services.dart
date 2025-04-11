import 'dart:developer';

import 'package:get/get_connect/connect.dart';
import 'package:stackup/model/users_model.dart';

class UsersServices extends GetConnect {
  Future<UsersModel?> fetchUsersService() async {
    try {
      final response = await get(
        'http://localhost:8000/api/user/usersList',
      ); // Android emulator localhost
      log(response.body.toString());

      if (response.statusCode == 200 && response.body != null) {
        return UsersModel.fromJson(response.body);
      } else {
        print('Failed to fetch UsersServices: ${response.statusText}');
        return null;
      }
    } catch (e) {
      print('Error fetching UsersServices: $e');
      return null;
    }
  }
}
