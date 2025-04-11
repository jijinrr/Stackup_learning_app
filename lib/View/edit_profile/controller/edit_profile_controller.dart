// profile_controller.dart
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:stackup/services/user_info_services.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;

  var email = ''.obs;
  var bio = ''.obs;
  var phoneNumber = ''.obs;
  var location = ''.obs;
  var imageUrl =
      'https://static.vecteezy.com/system/resources/thumbnails/035/544/575/small_2x/ai-generated-cheerful-black-man-looking-at-camera-isolated-on-transparent-background-african-american-male-person-portrait-png.png'
          .obs;

  late TextEditingController firstNameController,
      lastNameController,
      emailController,
      mobileNumberController,
      locationController,
      genderController,
      bioController,
      ageController;

  @override
  void onInit() {
    super.onInit();
    profileInfo();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();

    emailController = TextEditingController();
    mobileNumberController = TextEditingController();
    locationController = TextEditingController();
    genderController = TextEditingController();
    bioController = TextEditingController();
    ageController = TextEditingController();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    locationController.dispose();
    genderController.dispose();
    bioController.dispose();
    ageController.dispose();
    super.onClose();
  }

  void updateProfile({
    String? newFirstName,
    String? newLastName,
    String? newEmail,
    String? newBio,
    String? newPhone,
    String? newLocation,
  }) {
    if (newFirstName != null) firstName.value = newFirstName;
    if (newLastName != null) lastName.value = newLastName;
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

  void profileInfo() async {
    isLoading.value = true;
    var userinfoModel = await UserInfoServices().fetchUserInfoService();
    var user = userinfoModel?.users;
    firstNameController.text = user?.firstName ?? '';

    lastNameController.text = user?.lastName ?? '';
    mobileNumberController.text = user?.phoneNumber ?? '';
    locationController.text = user?.place ?? '';

    emailController.text = user?.email ?? '';
    bioController.text = user?.bio ?? '';

    // await Future.delayed(Duration(seconds: 5));
    isLoading.value = false;
  }
}
