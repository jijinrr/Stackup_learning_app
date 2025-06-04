import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackup/View/sign_up_screen/service/signup_service.dart';
import 'package:stackup/controller/auth_controller.dart';
import 'package:stackup/helper/my_colors.dart';
import 'package:stackup/widgets/custom_appbar.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController selectedCourseController =
      TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController progressLevelController = TextEditingController();

  // For dropdown selection
  String selectedGender = 'male';

  final AuthController authController = Get.find<AuthController>();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        notification: false,
        title: 'Create Account',
        leadingOnPressed: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: size.height * 0.02),
                // Welcome Text
                Text(
                  'Get Started',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Join our community today',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height * 0.03),

                // Personal Information Section
                _buildSectionTitle(context, 'Personal Information'),
                const SizedBox(height: 16),

                // First Name Field
                _buildTextField(
                  controller: firstNameController,
                  label: 'First Name',
                  hint: 'Enter your first name',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 16),

                // Last Name Field
                _buildTextField(
                  controller: lastNameController,
                  label: 'Last Name',
                  hint: 'Enter your last name',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 16),

                // Email Field
                _buildTextField(
                  controller: emailController,
                  label: 'Email',
                  hint: 'Enter your email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                // Phone Number Field
                _buildTextField(
                  controller: phoneNumberController,
                  label: 'Phone Number',
                  hint: 'Enter your phone number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),

                // Age Field
                _buildTextField(
                  controller: ageController,
                  label: 'Age',
                  hint: 'Enter your age',
                  icon: Icons.cake_outlined,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),

                // Gender Dropdown
                _buildDropdownField(
                  context: context,
                  label: 'Gender',
                  icon: Icons.person_outlined,
                ),
                const SizedBox(height: 16),

                // Location Field
                _buildTextField(
                  controller: placeController,
                  label: 'Location',
                  hint: 'Enter your city, state',
                  icon: Icons.location_on_outlined,
                ),
                const SizedBox(height: 16),

                // Education & Career Section
                _buildSectionTitle(context, 'Education & Career'),
                const SizedBox(height: 16),

                // Qualification Field
                _buildTextField(
                  controller: qualificationController,
                  label: 'Qualification',
                  hint: 'Enter your highest qualification',
                  icon: Icons.school_outlined,
                ),
                const SizedBox(height: 16),

                // Selected Course Field
                _buildTextField(
                  controller: selectedCourseController,
                  label: 'Selected Course',
                  hint: 'Enter your preferred course',
                  icon: Icons.menu_book_outlined,
                ),
                const SizedBox(height: 16),

                // Progress Level Field
                _buildTextField(
                  controller: progressLevelController,
                  label: 'Progress Level',
                  hint: 'Beginner, Intermediate, Advanced',
                  icon: Icons.trending_up_outlined,
                ),
                const SizedBox(height: 16),

                // Bio Field
                _buildTextField(
                  controller: bioController,
                  label: 'Bio',
                  hint: 'Tell us about yourself',
                  icon: Icons.description_outlined,
                  maxLines: 3,
                ),
                const SizedBox(height: 16),

                // Account Section
                _buildSectionTitle(context, 'Set Password'),
                const SizedBox(height: 16),

                // Password Field
                _buildTextField(
                  controller: passwordController,
                  label: 'Password',
                  hint: 'Create a strong password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),
                const SizedBox(height: 16),

                // Confirm Password Field
                _buildTextField(
                  controller: confirmPasswordController,
                  label: 'Confirm Password',
                  hint: 'Confirm your password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),
                const SizedBox(height: 16),

                // Terms and Conditions
                Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (value) {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'I agree to the Terms of Service and Privacy Policy',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),

                // Sign Up Button
                ElevatedButton(
                  onPressed: () async {
                    if (_validateInputs()) {
                      // createUserProfile();
                      authController.signUp(
                        emailController.text,
                        passwordController.text,
                      );
                    }

                    await SignupService()
                        .fetchUserInfoService(
                      email: emailController.text,
                      profileUrl: '',
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      age: int.parse(ageController.text),
                      qualification: qualificationController.text,
                      phoneNumber: phoneNumberController.text,
                      selectedCourse: selectedCourseController.text,
                      place: placeController.text,
                      bio: bioController.text,
                      progressLevel: progressLevelController.text,
                      coursePercentage: 0,
                      course: '',
                      typingPercentage: 0,
                      englishPercentage: 0,
                      softSkillPercentage: 0,
                      speakingPercentage: 0,
                      gender: selectedGender,
                    )
                        .then((value) {
                      if (value != null) {
                        Get.snackbar(
                          'Success',
                          'User profile created successfully',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      } else {
                        Get.snackbar(
                          'Error',
                          'Failed to create user profile',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    });

                    // print(firstNameController.text);
                    // print(lastNameController.text);
                    // print(emailController.text);
                    // print(phoneNumberController.text);
                    // print(qualificationController.text);
                    // print(passwordController.text);
                    // print(confirmPasswordController.text);
                    // print(ageController.text);
                    // print(selectedGender);
                    // print(selectedCourseController.text);
                    // print(placeController.text);
                    // print(bioController.text);
                    // print(progressLevelController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),

                // Sign In Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: Colors.grey[600],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: MyColors.red,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required BuildContext context,
    required String label,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedGender,
                  isExpanded: true,
                  hint: Text(label),
                  items: const [
                    DropdownMenuItem(
                      value: 'male',
                      child: Text('Male'),
                    ),
                    DropdownMenuItem(
                      value: 'female',
                      child: Text('Female'),
                    ),
                    DropdownMenuItem(
                      value: 'other',
                      child: Text('Other'),
                    ),
                  ],
                  onChanged: (value) {
                    // In a StatefulWidget, you'd use setState
                    // Here you'd need to use GetX state management
                    selectedGender = value!;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateInputs() {
    // Basic validation for required fields
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all required fields',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    // Email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(emailController.text)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    // Password match validation
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    // Password strength validation
    if (passwordController.text.length < 8) {
      Get.snackbar(
        'Error',
        'Password must be at least 8 characters long',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    // Age validation if provided
    if (ageController.text.isNotEmpty) {
      try {
        int age = int.parse(ageController.text);
        if (age <= 0 || age > 120) {
          Get.snackbar(
            'Error',
            'Please enter a valid age',
            snackPosition: SnackPosition.BOTTOM,
          );
          return false;
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'Please enter a valid age',
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    }

    return true;
  }

  // void createUserProfile() {
  //   // Create a user profile map with all the collected information

  //   // In a real app, you would save this data to your database
  //   // e.g., authController.createUserProfile(userProfile);

  //   // For demonstration purposes, we'll just log it
  //   // print('User Profile Created: $userProfile');
  //   Get.snackbar(
  //     'Success',
  //     'User profile created successfully',
  //     snackPosition: SnackPosition.BOTTOM,
  //   );
  // }
}
