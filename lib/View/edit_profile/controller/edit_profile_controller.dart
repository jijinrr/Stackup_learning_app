// profile_controller.dart
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var bio = ''.obs;
  var phoneNumber = ''.obs;
  var location = ''.obs;
  var imageUrl = 'https://via.placeholder.com/150'.obs;

  void updateProfile({
    String? newName,
    String? newEmail,
    String? newBio,
    String? newPhone,
    String? newLocation,
  }) {
    if (newName != null) name.value = newName;
    if (newEmail != null) email.value = newEmail;
    if (newBio != null) bio.value = newBio;
    if (newPhone != null) phoneNumber.value = newPhone;
    if (newLocation != null) location.value = newLocation;
  }

  Future<void> updateProfileImage() async {
    // Implement image picker functionality here
    // This is just a placeholder
    imageUrl.value = 'https://via.placeholder.com/150';
  }

  Future<void> saveProfile() async {
    // Implement API call or database save here
    Get.snackbar(
      'Success',
      'Profile updated successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
