// GetX controller for notifications
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackup/View/notifications_screen/notifiaction_screen.dart';

class NotificationsController extends GetxController {
  var notifications = <NotificationItem>[].obs;
  var selectedFilter = NotificationType.all.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    notifications.value = [
      NotificationItem(
        title: "New Course Available",
        message:
            "Introduction to Advanced Flutter Development is now available. Tap to explore the course.",
        time: "2 hours ago",
        icon: Icons.school,
        isRead: false,
        type: NotificationType.course,
      ),
      NotificationItem(
        title: "Assignment Due Today",
        message:
            "Your 'Building UI with Flutter' assignment is due today. Don't forget to submit!",
        time: "5 hours ago",
        icon: Icons.assignment,
        isRead: false,
        type: NotificationType.assignment,
      ),
      NotificationItem(
        title: "Quiz Result",
        message: "You scored 92% on the Dart Fundamentals quiz! Great work!",
        time: "Yesterday",
        icon: Icons.quiz,
        isRead: true,
        type: NotificationType.quiz,
      ),
      NotificationItem(
        title: "Study Reminder",
        message: "It's time for your scheduled Flutter study session.",
        time: "Yesterday",
        icon: Icons.alarm,
        isRead: true,
        type: NotificationType.reminder,
      ),
      NotificationItem(
        title: "Forum Activity",
        message: "Sarah commented on your question about state management.",
        time: "2 days ago",
        icon: Icons.forum,
        isRead: true,
        type: NotificationType.social,
      ),
      NotificationItem(
        title: "Weekly Progress",
        message:
            "You've completed 80% of your weekly learning goal. Keep it up!",
        time: "3 days ago",
        icon: Icons.bar_chart,
        isRead: true,
        type: NotificationType.progress,
      ),
      NotificationItem(
        title: "Limited Time Offer",
        message:
            "50% off on all premium courses this weekend! Use code LEARN50.",
        time: "4 days ago",
        icon: Icons.local_offer,
        isRead: true,
        type: NotificationType.promotion,
      ),
      NotificationItem(
        title: "New Feature",
        message:
            "Try our new interactive code challenges in the practice section!",
        time: "5 days ago",
        icon: Icons.new_releases,
        isRead: true,
        type: NotificationType.system,
      ),
    ];
  }

  List<NotificationItem> get filteredNotifications {
    if (selectedFilter.value == NotificationType.all) {
      return notifications;
    } else {
      return notifications
          .where((n) => n.type == selectedFilter.value)
          .toList();
    }
  }

  void markAsRead(String id) {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      notifications[index].isRead = true;
      notifications.refresh();
    }
  }

  void markAllAsRead() {
    for (var notification in notifications) {
      notification.isRead = true;
    }
    notifications.refresh();
  }

  void removeNotification(String id) {
    notifications.removeWhere((n) => n.id == id);
  }

  void clearAllNotifications() {
    notifications.clear();
  }

  int get unreadCount => notifications.where((n) => !n.isRead).length;
}
