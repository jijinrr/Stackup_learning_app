import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:stackup/View/attendance_screen/attendance_screen.dart';
import 'package:stackup/View/course_screen/courses_screen.dart';
import 'package:stackup/View/explore/explore_screen.dart';
import 'package:stackup/controller/auth_controller.dart';
import 'package:stackup/controller/user_info_controller.dart';
import 'package:stackup/controller/users_controller.dart';
import 'package:stackup/helper/my_colors.dart';
import 'package:stackup/routes/app_routes.dart';
import 'package:stackup/utils/sharedpreference.dart';
import 'package:stackup/widgets/custom_confirmation_dialouge.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void closeDrawer() {
      Get.back();
    }

    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       Colors.white,
        //       Colors.grey[50]!,
        //     ],
        //   ),
        // ),
        child: Column(
          children: [
            buildHeader(),
            // const SizedBox(height: 8),
            // _buildSearchBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _buildSectionTitle('Main Menu'),
                  _buildAnimatedDrawerItem(
                    context: context,
                    icon: Icons.home_rounded,
                    title: 'Home',
                    isActive: true,
                    badge: '3',
                  ),
                  _buildAnimatedDrawerItem(
                      context: context,
                      icon: Icons.explore_rounded,
                      title: 'Explore',
                      onTap: () {
                        Get.back();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AppWebView(
                            webUrl: 'https://stackup.dev',
                            title: 'Explore',
                          ),
                        ));
                      }),
                  _buildAnimatedDrawerItem(
                    context: context,
                    icon: TablerIcons.chart_bar,
                    title: 'Dashboard',
                    onTap: () {
                      final UsersController usersController =
                          Get.find<UsersController>();
                      usersController.fetchusers();

                      closeDrawer();
                      Get.toNamed(RouteNames.studentDashboard);
                    },
                  ),
                  _buildAnimatedDrawerItem(
                    context: context,
                    icon: Icons.line_axis,
                    title: 'Attendence',
                    onTap: () {
                      Get.to(AttendanceScreen());
                    },
                    // iconColor: Colors.amber,
                  ),
                  _buildAnimatedDrawerItem(
                      context: context,
                      icon: Icons.school_rounded,
                      title: 'My Courses',
                      badge: 'New',
                      onTap: () {
                        Get.to(CoursesScreen());
                      }),
                  const Divider(height: 32),
                  _buildSectionTitle('Personal'),
                  _buildAnimatedDrawerItem(
                    context: context,
                    icon: Icons.person_rounded,
                    title: 'Profile',
                    onTap: () {
                      closeDrawer();
                      Get.toNamed(RouteNames.profileScreen);
                      // Get.to(Themescreen());
                    },
                  ),
                  _buildAnimatedDrawerItem(
                      context: context,
                      icon: Icons.settings_rounded,
                      title: 'Settings',
                      onTap: () {
                        Get.back();
                        Get.toNamed(RouteNames.settingsScreen);
                      }),
                  const Divider(height: 32),
                  _buildSectionTitle('Support'),
                  _buildAnimatedDrawerItem(
                    context: context,
                    icon: Icons.help_outline_rounded,
                    title: 'Help Center',
                  ),
                  _buildAnimatedDrawerItem(
                    context: context,
                    icon: Icons.bug_report_rounded,
                    title: 'Report Bug',
                  ),
                ],
              ),
            ),
            _buildBottomSection(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    final UserInfoController userInfoController =
        Get.find<UserInfoController>();

    var userInfo = userInfoController.userInfoModel.value.users;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            MyColors.red,
            MyColors.red.withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    userInfo?.profileUrl ??
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                  ),
                ),
              ),
              Positioned(
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '${userInfo?.firstName} ${userInfo?.lastName}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified_rounded,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  'Premium Member',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildSearchBar() {
  //   return Padding(
  //     padding: const EdgeInsets.all(16),
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 16),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(12),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.withOpacity(0.1),
  //             blurRadius: 10,
  //             offset: const Offset(0, 2),
  //           ),
  //         ],
  //       ),
  //       child: const TextField(
  //         decoration: InputDecoration(
  //           icon: Icon(Icons.search_rounded),
  //           hintText: 'Search...',
  //           border: InputBorder.none,
  //           contentPadding: EdgeInsets.symmetric(vertical: 12),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildAnimatedDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    Color? textColor,
    Color? iconColor,
    bool isActive = false,
    String? badge,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            color:
                isActive ? MyColors.red.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color:
                    isActive ? MyColors.red : (iconColor ?? Colors.grey[700]),
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isActive
                        ? MyColors.red
                        : (textColor ?? Colors.grey[800]),
                    fontSize: 16,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              if (badge != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: badge == 'New' ? Colors.green : MyColors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return GestureDetector(
      onTap: () {
        Get.back();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomConfirmationDialouge(
              title: 'Logout',
              message: 'Are you sure you want to logout?',
              confirmText: 'Logout',
              cancelText: 'Cancel',
              onConfirm: () async {
                authController.signOut();
                await SharedPrefs.clearAll();
                Get.offAllNamed(RouteNames.loginScreen);
              },
              onCancel: () {
                Get.back(); // Close the dialog
              },
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: MyColors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.logout_rounded,
                color: MyColors.red,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'See you soon!',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildBottomSection() {
  //   final AuthController authController = Get.find<AuthController>();

  //   return GestureDetector(
  //     onTap: () {
  //       CustomConfirmationDialouge(
  //           message: '', onCancel: () {}, title: '', onConfirm: () {});
  //     },
  // onTap: () => authController.signOut(),
  //     child: Container(
  //       padding: const EdgeInsets.all(16),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.withOpacity(0.1),
  //             blurRadius: 10,
  //             offset: const Offset(0, -5),
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         children: [
  //           Container(
  //             padding: const EdgeInsets.all(8),
  //             decoration: BoxDecoration(
  //               color: MyColors.red.withOpacity(0.1),
  //               shape: BoxShape.circle,
  //             ),
  //             child: Icon(
  //               Icons.logout_rounded,
  //               color: MyColors.red,
  //               size: 20,
  //             ),
  //           ),
  //           const SizedBox(width: 12),
  //           const Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text(
  //                   'Logout',
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 Text(
  //                   'See you soon!',
  //                   style: TextStyle(
  //                     fontSize: 12,
  //                     color: Colors.grey,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Icon(
  //             Icons.arrow_forward_ios_rounded,
  //             color: Colors.grey[400],
  //             size: 16,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
