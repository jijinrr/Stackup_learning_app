import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackup/View/edit_profile/controller/edit_profile_controller.dart';
import 'package:stackup/controller/user_info_controller.dart';
import 'package:stackup/widgets/loading_screen.dart';

class EditProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();

  // Define app colors
  final Color primaryRed = const Color(0xFFE53935);
  final Color secondaryRed = const Color(0xFFEF5350);
  final Color lightRed = const Color(0xFFFFCDD2);
  final Color darkRed = const Color(0xFFC62828);
  final Color pureWhite = Colors.white;
  final Color offWhite = const Color(0xFFF5F5F5);

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pureWhite,
      appBar: AppBar(
        backgroundColor: primaryRed,
        elevation: 0,
        title: const Text(
          'My Learning Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(Icons.help_outline, color: Colors.white),
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    title: const Text('Profile Help'),
                    content: const Text(
                        'Your profile information helps personalize your learning experience. '
                        'Make sure to keep your details up to date for better course recommendations.'),
                    actions: [
                      TextButton(
                        child:
                            Text('Got it', style: TextStyle(color: primaryRed)),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Obx(() {
        final UserInfoController userInfoController =
            Get.find<UserInfoController>();

        var userInfo = userInfoController.userInfoModel.value.users;
        return controller.isLoading.value
            ? LoadingScreen()
            : Stack(
                children: [
                  // Custom app bar extension with wave
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: primaryRed,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),

                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // Profile card
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: pureWhite,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 30),

                              // Profile image
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [secondaryRed, darkRed],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                secondaryRed.withOpacity(0.5),
                                            blurRadius: 15,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        radius: 65,
                                        backgroundColor: lightRed,
                                        backgroundImage: NetworkImage(
                                            userInfo?.profileUrl ?? ''),
                                      )),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: darkRed,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: pureWhite, width: 2),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                      child: IconButton(
                                        iconSize: 20,
                                        icon: const Icon(Icons.camera_alt,
                                            color: Colors.white),
                                        onPressed:
                                            controller.updateProfileImage,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 15),

                              // User name
                              Text(
                                '${userInfo?.firstName} ${userInfo?.lastName}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF303030),
                                ),
                              ),

                              const SizedBox(height: 5),

                              // Learning level indicator
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 6),
                                decoration: BoxDecoration(
                                  color: lightRed,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.school,
                                        size: 16, color: darkRed),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Advanced Learner',
                                      style: TextStyle(
                                        color: darkRed,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 25),

                              // Progress stats
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: offWhite,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildStatColumn('Courses', '12'),
                                    _buildVerticalDivider(),
                                    _buildStatColumn('Completed', '8'),
                                    _buildVerticalDivider(),
                                    _buildStatColumn('Hours', '47'),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 25),
                            ],
                          ),
                        ),

                        const SizedBox(height: 25),

                        // Personal Information Section
                        _buildSectionHeader('Personal Information'),

                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: pureWhite,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                spreadRadius: 0,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                buildTextField(
                                  label: 'First Name',
                                  icon: Icons.person_outline,
                                  initialValue:
                                      controller.firstNameController.text,
                                  onChanged: (value) => controller
                                      .updateProfile(newFirstName: value),
                                  primaryColor: primaryRed,
                                ),
                                const SizedBox(height: 15),
                                buildTextField(
                                  label: 'Last Name',
                                  icon: Icons.person_outline,
                                  initialValue:
                                      controller.lastNameController.text,
                                  onChanged: (value) => controller
                                      .updateProfile(newLastName: value),
                                  primaryColor: primaryRed,
                                ),
                                const SizedBox(height: 15),
                                buildTextField(
                                  label: 'Email Address',
                                  icon: Icons.email_outlined,
                                  initialValue: controller.emailController.text,
                                  onChanged: (value) =>
                                      controller.updateProfile(newEmail: value),
                                  keyboardType: TextInputType.emailAddress,
                                  primaryColor: primaryRed,
                                ),
                                const SizedBox(height: 15),
                                buildTextField(
                                  label: 'Phone Number',
                                  icon: Icons.phone_outlined,
                                  initialValue:
                                      controller.mobileNumberController.text,
                                  onChanged: (value) =>
                                      controller.updateProfile(newPhone: value),
                                  keyboardType: TextInputType.phone,
                                  primaryColor: primaryRed,
                                ),
                                const SizedBox(height: 15),
                                buildTextField(
                                  label: 'Location',
                                  icon: Icons.location_on_outlined,
                                  initialValue:
                                      controller.locationController.text,
                                  onChanged: (value) => controller
                                      .updateProfile(newLocation: value),
                                  primaryColor: primaryRed,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),

                        // Learning Preferences Section
                        _buildSectionHeader('Learning Preferences'),

                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: pureWhite,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                spreadRadius: 0,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                _buildDropdownField(
                                  label: 'Primary Learning Goal',
                                  icon: Icons.emoji_events_outlined,
                                  value: 'Career Advancement',
                                  options: [
                                    'Career Advancement',
                                    'Skill Development',
                                    'Personal Interest',
                                    'Certification'
                                  ],
                                  primaryColor: primaryRed,
                                ),
                                const SizedBox(height: 15),
                                _buildDropdownField(
                                  label: 'Preferred Study Time',
                                  icon: Icons.access_time,
                                  value: 'Evening',
                                  options: [
                                    'Morning',
                                    'Afternoon',
                                    'Evening',
                                    'Late Night'
                                  ],
                                  primaryColor: primaryRed,
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),

                        // About Section
                        _buildSectionHeader('About Me'),

                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: pureWhite,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                spreadRadius: 0,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: buildTextField(
                              label: 'Bio',
                              icon: Icons.description_outlined,
                              initialValue: controller.bioController.text,
                              onChanged: (value) =>
                                  controller.updateProfile(newBio: value),
                              maxLines: 4,
                              hintText:
                                  'Tell other learners about yourself, your goals, and interests...',
                              primaryColor: primaryRed,
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),

                        // Account Settings Section
                        _buildSectionHeader('Account Settings'),

                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: pureWhite,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                spreadRadius: 0,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _buildSettingsTile(
                                icon: Icons.lock_outline,
                                title: 'Change Password',
                                onTap: () => Get.toNamed('/change-password'),
                                primaryRed: primaryRed,
                              ),
                              _buildDivider(),
                              _buildSettingsTile(
                                icon: Icons.notifications_none_outlined,
                                title: 'Notification Settings',
                                onTap: () =>
                                    Get.toNamed('/notification-settings'),
                                primaryRed: primaryRed,
                              ),
                              _buildDivider(),
                              _buildSettingsTile(
                                icon: Icons.language_outlined,
                                title: 'Language Preferences',
                                onTap: () =>
                                    Get.toNamed('/language-preferences'),
                                primaryRed: primaryRed,
                              ),
                              _buildDivider(),
                              _buildSettingsTile(
                                icon: Icons.privacy_tip_outlined,
                                title: 'Privacy Settings',
                                onTap: () => Get.toNamed('/privacy-settings'),
                                primaryRed: primaryRed,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Save Button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              controller.saveProfile();
                              Get.snackbar(
                                'Profile Updated',
                                'Your learning profile has been successfully updated.',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: darkRed,
                                colorText: Colors.white,
                                margin: const EdgeInsets.all(20),
                                icon: const Icon(Icons.check_circle,
                                    color: Colors.white),
                                duration: const Duration(seconds: 3),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryRed,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 5,
                              shadowColor: primaryRed.withOpacity(0.5),
                              minimumSize: const Size(double.infinity, 55),
                            ),
                            child: const Text(
                              'SAVE PROFILE',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ],
              );
      }),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
      child: Row(
        children: [
          Container(
            height: 16,
            width: 4,
            decoration: BoxDecoration(
              color: primaryRed,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: darkRed,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required IconData icon,
    required String initialValue,
    required Function(String) onChanged,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? hintText,
    required Color primaryColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: offWhite,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: TextEditingController(text: initialValue),
        onChanged: onChanged,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon: Icon(icon, color: primaryColor),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelStyle: TextStyle(color: primaryColor.withOpacity(0.8)),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required String value,
    required List<String> options,
    required Color primaryColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        color: offWhite,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        icon: Icon(Icons.arrow_drop_down, color: primaryColor),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: primaryColor),
          border: InputBorder.none,
          labelStyle: TextStyle(color: primaryColor.withOpacity(0.8)),
        ),
        items: options.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {},
      ),
    );
  }

  Widget buildTag(String label, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: lightRed,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(color: darkRed),
          ),
          const SizedBox(width: 4),
          Icon(Icons.close, size: 16, color: darkRed),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: darkRed,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.grey.withOpacity(0.3),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 20,
      endIndent: 20,
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color primaryRed,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: primaryRed),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
