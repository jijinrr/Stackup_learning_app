import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackup/View/edit_profile/controller/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        elevation: 0,
        actions: [
          TextButton(
            onPressed: controller.saveProfile,
            child: Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            // Profile Image
            Center(
              child: Stack(
                children: [
                  Obx(() => CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            NetworkImage(controller.imageUrl.value),
                      )),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.camera_alt, color: Colors.white),
                        onPressed: controller.updateProfileImage,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // Form Fields
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildTextField(
                    label: 'Full Name',
                    icon: Icons.person,
                    initialValue: controller.name.value,
                    onChanged: (value) =>
                        controller.updateProfile(newName: value),
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    label: 'Email',
                    icon: Icons.email,
                    initialValue: controller.email.value,
                    onChanged: (value) =>
                        controller.updateProfile(newEmail: value),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    label: 'Phone Number',
                    icon: Icons.phone,
                    initialValue: controller.phoneNumber.value,
                    onChanged: (value) =>
                        controller.updateProfile(newPhone: value),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    label: 'Location',
                    icon: Icons.location_on,
                    initialValue: controller.location.value,
                    onChanged: (value) =>
                        controller.updateProfile(newLocation: value),
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    label: 'Bio',
                    icon: Icons.description,
                    initialValue: controller.bio.value,
                    onChanged: (value) =>
                        controller.updateProfile(newBio: value),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required String initialValue,
    required Function(String) onChanged,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: TextEditingController(text: initialValue),
        onChanged: onChanged,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
