import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:network_info_plus/network_info_plus.dart';

class UserLocationController extends GetxController {
  final String allowedIpAddress; // The IP address that should match

  UserLocationController(this.allowedIpAddress);

  final NetworkInfo _networkInfo = NetworkInfo();
  RxString currentIp = ''.obs;
  Rx<DateTime?> checkInTime = Rx<DateTime?>(null);
  Rx<DateTime?> checkOutTime = Rx<DateTime?>(null);
  RxString status = ''.obs;
  RxBool isLoading = false.obs;

  Future<void> getCurrentIp() async {
    isLoading.value = true;
    try {
      final wifiIp = await _networkInfo.getWifiIP();
      currentIp.value = wifiIp ?? 'Unknown';
    } catch (e) {
      status.value = 'Error getting IP address: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handleCheckIn() async {
    await getCurrentIp();

    if (currentIp.value == allowedIpAddress) {
      checkInTime.value = DateTime.now();
      status.value = 'Successfully checked in';
    } else {
      status.value = 'Error: IP address does not match allowed address';
    }
  }

  Future<void> handleCheckOut() async {
    await getCurrentIp();

    if (currentIp.value == allowedIpAddress) {
      checkOutTime.value = DateTime.now();
      status.value = 'Successfully checked out';
    } else {
      status.value = 'Error: IP address does not match allowed address';
    }
  }

  String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'Not set';
    return DateFormat('dd MMM yyyy - hh:mm a').format(dateTime);
  }
}
