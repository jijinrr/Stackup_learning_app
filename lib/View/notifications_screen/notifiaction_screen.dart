import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackup/View/notifications_screen/controller/notifications_controller.dart';
import 'package:stackup/helper/my_colors.dart';
import 'package:stackup/routes/app_routes.dart';

// Define a custom color class

// Enum for notification types
enum NotificationType {
  all,
  course,
  assignment,
  quiz,
  reminder,
  social,
  progress,
  promotion,
  system,
}

// Notification model class
class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String time;
  final IconData icon;
  bool isRead;
  final NotificationType type;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.isRead,
    required this.type,
  }) : id = DateTime.now().millisecondsSinceEpoch.toString() + title;
}

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final NotificationsController controller =
      Get.find<NotificationsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: MyColors.red,
        elevation: 0,
        title: Text(
          'Notifications',
          style: TextStyle(
            color: MyColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: MyColors.white),
            onPressed: () {
              // Navigate to notification settings
              Get.toNamed(RouteNames.settingsScreen);
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: MyColors.white),
            onSelected: (value) {
              if (value == 'mark_all_read') {
                controller.markAllAsRead();
              } else if (value == 'clear_all') {
                controller.clearAllNotifications();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'mark_all_read',
                child: Text('Mark all as read'),
              ),
              const PopupMenuItem(
                value: 'clear_all',
                child: Text('Clear all notifications'),
              ),
            ],
          ),
        ],
        leading: IconButton(
          padding: const EdgeInsets.only(left: 10),
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: MyColors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildNotificationFilters(),
          _buildNotificationCounter(),
          Expanded(
            child: Obx(() {
              return controller.notifications.isEmpty
                  ? _buildEmptyState()
                  : _buildNotificationsList();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationFilters() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: MyColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          _buildFilterChip(NotificationType.all, 'All'),
          _buildFilterChip(NotificationType.course, 'Courses'),
          _buildFilterChip(NotificationType.assignment, 'Assignments'),
          _buildFilterChip(NotificationType.quiz, 'Quizzes'),
          _buildFilterChip(NotificationType.reminder, 'Reminders'),
          _buildFilterChip(NotificationType.social, 'Social'),
          _buildFilterChip(NotificationType.progress, 'Progress'),
          _buildFilterChip(NotificationType.promotion, 'Offers'),
          _buildFilterChip(NotificationType.system, 'System'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(NotificationType type, String label) {
    return Obx(() {
      final isSelected = controller.selectedFilter.value == type;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FilterChip(
          label: Text(
            label,
            style: TextStyle(
              color: isSelected ? MyColors.white : MyColors.darkGrey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          selected: isSelected,
          backgroundColor: MyColors.grey,
          selectedColor: MyColors.red,
          onSelected: (selected) {
            if (selected) {
              controller.selectedFilter.value = type;
            }
          },
        ),
      );
    });
  }

  Widget _buildNotificationCounter() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Recent Notifications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Obx(() {
            final unreadCount = controller.unreadCount;
            return unreadCount > 0
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: MyColors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$unreadCount new',
                      style: TextStyle(
                        color: MyColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off,
            size: 80,
            color: MyColors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'No notifications yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'We\'ll notify you when there are new courses, assignments, or other important updates',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MyColors.darkGrey,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.red,
              foregroundColor: MyColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              controller.loadNotifications();
            },
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    return Obx(() {
      final notifications =
          controller.selectedFilter.value == NotificationType.all
              ? controller.notifications
              : controller.notifications
                  .where((n) => n.type == controller.selectedFilter.value)
                  .toList();

      return ListView.separated(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final notification = notifications[index];

          return Dismissible(
            key: Key(notification.id),
            background: Container(
              color: MyColors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                Icons.delete,
                color: MyColors.white,
              ),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              controller.removeNotification(notification.id);
            },
            child: InkWell(
              onTap: () {
                controller.markAsRead(notification.id);
                // Navigate to notification detail or related screen
                Get.snackbar(
                  notification.title,
                  'Opening notification details...',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: MyColors.red.withOpacity(0.1),
                  colorText: MyColors.red,
                  duration: const Duration(seconds: 1),
                );
              },
              child: Container(
                color: notification.isRead
                    ? MyColors.white
                    : MyColors.red.withOpacity(0.3),
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNotificationIcon(notification),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  notification.title,
                                  style: TextStyle(
                                    fontWeight: notification.isRead
                                        ? FontWeight.normal
                                        : FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              if (!notification.isRead)
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: MyColors.red,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            notification.message,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                notification.time,
                                style: TextStyle(
                                  color: MyColors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              PopupMenuButton<String>(
                                icon: Icon(
                                  Icons.more_horiz,
                                  color: MyColors.grey,
                                  size: 16,
                                ),
                                onSelected: (value) {
                                  if (value == 'mark_read') {
                                    controller.markAsRead(notification.id);
                                  } else if (value == 'delete') {
                                    controller
                                        .removeNotification(notification.id);
                                  }
                                },
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 'mark_read',
                                    child: Text(notification.isRead
                                        ? 'Mark as unread'
                                        : 'Mark as read'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildNotificationIcon(NotificationItem notification) {
    Color iconColor;
    switch (notification.type) {
      case NotificationType.course:
        iconColor = Colors.blue;
        break;
      case NotificationType.assignment:
        iconColor = Colors.orange;
        break;
      case NotificationType.quiz:
        iconColor = Colors.purple;
        break;
      case NotificationType.reminder:
        iconColor = Colors.teal;
        break;
      case NotificationType.social:
        iconColor = Colors.green;
        break;
      case NotificationType.progress:
        iconColor = Colors.amber;
        break;
      case NotificationType.promotion:
        iconColor = Colors.pink;
        break;
      case NotificationType.system:
        iconColor = Colors.indigo;
        break;
      default:
        iconColor = MyColors.red;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        notification.icon,
        color: iconColor,
        size: 24,
      ),
    );
  }
}
