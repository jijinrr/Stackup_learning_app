// models/course.dart
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:stackup/View/drawer_screen.dart';
import 'package:stackup/View/home/controller/home_controller.dart';
import 'package:stackup/View/home/widgets/user_location_checkin_widgetsd.dart';
import 'package:stackup/controller/auth_controller.dart';
import 'package:stackup/controller/user_info_controller.dart';
import 'package:stackup/helper/my_colors.dart';
import 'dart:math' as math;

import 'package:stackup/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeController homeController = Get.find<HomeController>();
  final UserInfoController userInfoController = Get.find<UserInfoController>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: Drawer(
        child: DrawerScreen(),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                expandedHeight: 100.0,
                backgroundColor: MyColors.red,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                leading: IconButton(
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  icon: Icon(TablerIcons.menu_deep, color: Colors.white),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Remix.notification_2_fill,
                      color: MyColors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Get.toNamed(RouteNames.notificationScreen);
                    },
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1.1,
                  titlePadding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                  title: Obx(() {
                    var userInfo = userInfoController.userInfoModel.value.users;

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${homeController.getGreeting()}, ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(userInfo?.firstName ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(width: 5),
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: const Text(
                            '\u{1F44B}',
                            style: TextStyle(fontSize: 28),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search courses...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: UserLocationScreen(
                  allowedIpAddress: '192.168.72.107',
                ),
              ),
              SliverToBoxAdapter(
                child: _buildContinueLearning(),
              ),
              SliverToBoxAdapter(
                child: _buildPopularCourses(),
              ),
              SliverToBoxAdapter(
                child: _buildCategories(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search courses...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: MyColors.white,
        ),
      ),
    );
  }

  Widget _buildContinueLearning() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Continue Learning',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 160,
            child: Obx(() => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: homeController.courses.length,
                  itemBuilder: (context, index) {
                    final course = homeController.courses[index];
                    return Container(
                      width: 280,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${course.lessonsCount} lessons',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 15),
                          LinearProgressIndicator(
                            value: course.progress,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              MyColors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${(course.progress * 100).toInt()}% Complete',
                            style: TextStyle(
                              color: MyColors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularCourses() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Popular Courses',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Obx(() => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: homeController.courses.length,
                itemBuilder: (context, index) {
                  final course = homeController.courses[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple[50],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.play_circle_outline,
                            color: MyColors.deepPurple,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                course.description,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                _buildCategoryCard('Development', Icons.code, Colors.blue),
                _buildCategoryCard('Design', Icons.brush, Colors.orange),
                _buildCategoryCard('Business', Icons.business, Colors.green),
                _buildCategoryCard('Marketing', Icons.trending_up, Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, MaterialColor color) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: color[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              color: color[900],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class Course {
  final String title;
  final String description;
  final String imageUrl;
  final int lessonsCount;
  final double progress;

  Course({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.lessonsCount,
    required this.progress,
  });
}
