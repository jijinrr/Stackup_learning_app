import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackup/View/edit_profile/edit_profile_screen.dart';
import 'package:stackup/controller/user_info_controller.dart';
import 'package:stackup/helper/my_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(), // Uncommented and using the defined method name
          // _buildProfileStats(),
          buildActionButtons(),
          SliverToBoxAdapter(
            // Wrap _buildProfileSections in SliverToBoxAdapter
            child: _buildProfileSections(),
          ),
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    final UserInfoController userInfoController =
        Get.find<UserInfoController>();
    var userInfo = userInfoController.userInfoModel.value.users;

    var userName = '${userInfo?.firstName} ${userInfo?.lastName}';
    return SliverAppBar(
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: MyColors.white,
          )),
      expandedHeight: 220,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Cover Image
            Image.network(
              'https://images.unsplash.com/photo-1579546929518-9e396f3cc809',
              fit: BoxFit.cover,
            ),
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            // Profile Image and Name
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                        userInfo?.profileUrl ??
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    userName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on,
                          color: Colors.white.withOpacity(0.8), size: 16),
                      const SizedBox(width: 4),
                      Text(
                        userInfo?.place ?? '',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildProfileStats() {
  //   return SliverToBoxAdapter(
  //     // Wrap in SliverToBoxAdapter since it contains a Row (RenderBox)
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(vertical: 20),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           _buildStatItem('Courses', '12'),
  //           _buildDivider(),
  //           _buildStatItem('Following', '256'),
  //           _buildDivider(),
  //           _buildStatItem('Followers', '1.2K'),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget buildDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.grey[300],
    );
  }

  Widget buildActionButtons() {
    return SliverToBoxAdapter(
      // Wrap in SliverToBoxAdapter since it contains a Row (RenderBox)
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => EditProfileScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.red,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share_rounded),
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSections() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('About Me'),
          const SizedBox(height: 12),
          buildAboutMe(),
          const SizedBox(height: 24),
          _buildSectionTitle('My Achievements'),
          const SizedBox(height: 12),
          _buildAchievements(),
          const SizedBox(height: 24),
          _buildSectionTitle('Current Courses'),
          const SizedBox(height: 12),
          _buildCourses(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('See All'),
        ),
      ],
    );
  }

  Widget buildAboutMe() {
    final UserInfoController userInfoController =
        Get.find<UserInfoController>();
    var userInfo = userInfoController.userInfoModel.value.users;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        userInfo?.bio ?? '',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildAchievements() {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildAchievementCard('Quick Learner', '🚀', Colors.blue),
          _buildAchievementCard('Top Contributor', '🏆', Colors.orange),
          _buildAchievementCard('Problem Solver', '💡', Colors.green),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(String title, String emoji, Color color) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: color.withOpacity(0.8),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourses() {
    return Column(
      children: [
        _buildCourseCard(
          'Flutter Development',
          '85% Complete',
          Icons.phone_android_rounded,
          0.85,
        ),
        const SizedBox(height: 12),
        _buildCourseCard(
          'UI/UX Design',
          '60% Complete',
          Icons.design_services_rounded,
          0.6,
        ),
      ],
    );
  }

  Widget _buildCourseCard(
      String title, String progress, IconData icon, double value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: MyColors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: MyColors.red),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: value,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(MyColors.red),
                ),
                const SizedBox(height: 4),
                Text(
                  progress,
                  style: TextStyle(
                    color: Colors.grey[600],
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
}
