import 'package:get/get.dart';
import 'package:stackup/model/user_info_model.dart';
import 'package:stackup/services/user_info_services.dart';

class UserInfoController extends GetxController {
  var userInfoModel = UserInfoModel().obs;
  var isLoading = false.obs;
  RxInt index = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchuserInfo();
  }

  void fetchuserInfo() async {
    isLoading.value = true;
    final user = await UserInfoServices().fetchUserInfoService();
    if (user != null) {
      userInfoModel.value = user;
    }
    isLoading.value = false;
  }
}
