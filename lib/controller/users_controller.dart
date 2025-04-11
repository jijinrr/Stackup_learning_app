import 'package:get/get.dart';
import 'package:stackup/model/users_model.dart';
import 'package:stackup/services/users_services.dart';

class UsersController extends GetxController {
  var usersModel = UsersModel().obs;
  var isLoading = false.obs;
  RxInt index = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchusers();
  }

  void fetchusers() async {
    isLoading.value = true;
    final user = await UsersServices().fetchUsersService();
    if (user != null) {
      usersModel.value = user;
    }
    isLoading.value = false;
  }
}
