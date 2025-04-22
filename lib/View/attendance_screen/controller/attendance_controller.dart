import 'package:get/get.dart';
import 'package:stackup/View/attendance_screen/model/attendance_model.dart';
import 'package:stackup/View/attendance_screen/services/attendance_services.dart';

class AttendanceController extends GetxController {
  var attendanceModel = AttendanceModel().obs;
  var isLoading = false.obs;
  RxInt index = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchuserInfo();
  }

  void fetchuserInfo() async {
    isLoading.value = true;
    final attendance = await AttendanceServices().fetchAttendanceService();
    if (attendance != null) {
      attendanceModel.value = attendance;
    }
    isLoading.value = false;
  }
}
