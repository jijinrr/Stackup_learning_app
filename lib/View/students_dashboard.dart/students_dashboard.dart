import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:stackup/controller/user_info_controller.dart';
import 'package:stackup/controller/users_controller.dart';
import 'package:stackup/helper/my_colors.dart';
import 'package:stackup/widgets/loading_screen.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final UsersController usersController = Get.find<UsersController>();

    return Scaffold(
      body: Obx(
        () => usersController.isLoading.value
            ? LoadingScreen()
            : CustomScrollView(
                slivers: [
                  _buildAppBar(),
                  SliverToBoxAdapter(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTopPerformers(),
                            const SizedBox(height: 24),
                            _buildPerformanceOverview(),
                            const SizedBox(height: 24),
                            _buildStudentsList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: MyColors.red,
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  Widget _buildAppBar() {
    final UsersController usersController = Get.find<UsersController>();
    var students = usersController.usersModel.value.users ?? [];
    var totalStudents = students.length;

    double totalPercentage = 0.0;

    for (var student in students) {
      var percentage =
          double.tryParse(student.coursePercentage?.toString() ?? '0') ?? 0.0;
      totalPercentage += percentage;
    }

    // Calculate average, protect against division by zero
    double averageScore =
        totalStudents > 0 ? totalPercentage / totalStudents : 0.0;

    // Format to 1 decimal place
    String averageScoreFormatted = averageScore.toStringAsFixed(1);

    return SliverAppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      backgroundColor: MyColors.red,
      expandedHeight: 150,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [MyColors.red, MyColors.red],
            ),
          ),
        ),
      ),
      title: Text(
        'Dashboard',
        style: TextStyle(
          color: MyColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: MyColors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.filter_list, color: MyColors.white),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(Icons.arrow_back_ios, color: MyColors.white),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard('Total Students', '$totalStudents'),
              _buildStatCard('Average Score', averageScoreFormatted),
              _buildStatCard('Pass Rate', '92%'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPerformers() {
    final UsersController usersController = Get.find<UsersController>();
    var students = usersController.usersModel.value.users ?? [];

    // Sort students by coursePercentage (descending)
    students.sort((a, b) {
      double aScore =
          double.tryParse(a.coursePercentage?.toString() ?? '0') ?? 0.0;
      double bScore =
          double.tryParse(b.coursePercentage?.toString() ?? '0') ?? 0.0;
      return bScore.compareTo(aScore);
    });

    // Take top 3
    final topStudents = students.take(3).toList();

    // Rank colors
    final rankColors = [
      Colors.amber,
      Colors.grey[400]!,
      Colors.brown[300]!,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Top Performers',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: topStudents.length,
            itemBuilder: (context, index) {
              final student = topStudents[index];
              final rank = "${index + 1}${_rankSuffix(index + 1)}";

              return _buildTopPerformerCard(
                name: student.firstName ?? 'Unknown',
                grade: '${student.coursePercentage ?? '0.0'}%',
                rank: rank,
                image: student.profileUrl ?? '',
                color: rankColors[index],
              );
            },
          ),
        ),
      ],
    );
  }

  String _rankSuffix(int number) {
    if (number == 1) return 'st';
    if (number == 2) return 'nd';
    if (number == 3) return 'rd';
    return 'th';
  }

  Widget _buildTopPerformerCard({
    required String name,
    required String grade,
    required String rank,
    required String image,
    required Color color,
  }) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(image),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    rank,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            grade,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceOverview() {
    final UserInfoController userInfoController =
        Get.find<UserInfoController>();
    final user = userInfoController.userInfoModel.value.users;

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Class Performance',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 250,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 100,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    // tooltipBgColor: Colors.black87,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${rod.toY.toInt()}%',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 42,
                      getTitlesWidget: (value, meta) {
                        const subjects = [
                          'Soft Skills',
                          'Speaking',
                          'English',
                          'Typing'
                        ];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            subjects[value.toInt()],
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}%',
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _buildBarGroup(
                      0, user.softSkillPercentage?.toInt() ?? 0, Colors.blue),
                  _buildBarGroup(
                      1, user.speakingPercentage?.toInt() ?? 0, Colors.green),
                  _buildBarGroup(
                      2, user.englishPercentage?.toInt() ?? 0, Colors.orange),
                  _buildBarGroup(
                      3, user.typingPercentage?.toInt() ?? 0, Colors.red),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, int y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y.toDouble(),
          color: color,
          width: 16,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildStudentsList() {
    final UsersController usersController = Get.find<UsersController>();

    return Obx(() {
      // Access the reactive users list inside Obx
      final userData = usersController.usersModel.value.users ?? [];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'All Students',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.sort),
                label: const Text('Sort by'),
              ),
            ],
          ),
          ListView.builder(
            padding: EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: userData
                .length, // No need for null check here since we default to empty list
            itemBuilder: (context, index) {
              var student = userData[index];

              return _buildStudentCard(
                name: '${student.firstName} ${student.lastName}',
                grade: '${student.coursePercentage}%',
                subjects: student.course ?? 'N/A',
                // Default to 'flat' if null
              );
            },
          ),
        ],
      );
    });
  }

  Widget _buildStudentCard({
    required String name,
    required String grade,
    required String subjects,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey[200],
            child: Text(
              name.substring(0, 1),
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subjects,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                grade,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
