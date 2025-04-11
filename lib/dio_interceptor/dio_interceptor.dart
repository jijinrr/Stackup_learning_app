import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      // log('user token is $token');
      options.headers['Authorization'] = 'Bearer $token';
    } else {
      log('token null');
    }
    log('calling api is ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expired, try to refresh it
      // log('Token expired, attempting to refresh token');
      // await LogoutService.fetchLogOut();
      // logoutController.logout();
      // vitalSdkController.logOutVital();
      // CustomSnackBar.show(
      //   navigator!.context,
      //   comment: "${err.response?.statusMessage}",
      //   backgroundColor: MyColors.primaryColor,
      //   textColor: MyColors.white,
      //   icon: Icons.error,
      // );
      // final newToken = await _attemptTokenRefresh();
      // if (newToken != null) {
      //   final SharedPreferences prefs = await SharedPreferences.getInstance();
      //   await prefs.setString('token', newToken);
      //   // Retry the failed request with the new token
      //   final RequestOptions requestOptions = err.requestOptions;
      //   requestOptions.headers['Authorization'] = 'Bearer $newToken';
      //   try {
      //     final response = await Dio().request(
      //       requestOptions.path,
      //       options: Options(
      //         method: requestOptions.method,
      //         headers: requestOptions.headers,
      //       ),
      //       data: requestOptions.data,
      //       queryParameters: requestOptions.queryParameters,
      //     );
      //     return handler.resolve(response);
      //   } catch (e) {
      //     return handler.next(e as DioException);
      //   }
      // }
    }
    return handler.next(err);
  }
  // Future<String?> _attemptTokenRefresh() async {
  //   final refreshTokenModel = await RefreshTokenService.fetchRefreshToken();
  //   return refreshTokenModel?.data?.token;
  // }
}

class ApiClient {
  static final Dio _dio = Dio()..interceptors.add(TokenInterceptor());
  static Dio getDio() {
    return _dio;
  }
}
