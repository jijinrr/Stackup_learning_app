import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackup/controller/theme_controller.dart';
import 'package:stackup/helper/my_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _downloadOverWifi = true;
  double _textSize = 16.0;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor, // Use theme background
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          'Settings',
          style: TextStyle(
            color: Theme.of(context).appBarTheme.foregroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSettingsSection('Account Settings', [
              _buildSettingItem(
                'Profile Information',
                Icons.person,
                trailing: Icon(Icons.chevron_right, color: MyColors.grey),
                onTap: () {},
              ),
              _buildSettingItem(
                'Change Password',
                Icons.lock,
                trailing: Icon(Icons.chevron_right, color: MyColors.grey),
                onTap: () {},
              ),
              _buildSettingItem(
                'Linked Accounts',
                Icons.link,
                trailing: Icon(Icons.chevron_right, color: MyColors.grey),
                onTap: () {},
              ),
            ]),
            Divider(height: 1, thickness: 1, color: MyColors.lightgreyline),
            _buildSettingsSection('Learning Preferences', [
              _buildSettingItem(
                'Subject Interests',
                Icons.category,
                trailing: Icon(Icons.chevron_right, color: MyColors.grey),
                onTap: () {},
              ),
              _buildSettingItem(
                'Learning Schedule',
                Icons.calendar_today,
                trailing: Icon(Icons.chevron_right, color: MyColors.grey),
                onTap: () {},
              ),
              _buildSettingItem(
                'Difficulty Level',
                Icons.bar_chart,
                trailing: Text(
                  'Intermediate',
                  style: TextStyle(color: MyColors.grey),
                ),
                onTap: () {},
              ),
            ]),
            Divider(height: 1, thickness: 1, color: MyColors.lightgreyline),
            _buildSettingsSection('App Settings', [
              _buildSettingItem(
                'Notifications',
                Icons.notifications,
                trailing: Switch(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                  activeColor: MyColors.primaryColor,
                ),
              ),
              _buildSettingItem(
                'Dark Mode',
                Icons.dark_mode,
                trailing: Obx(() => Switch(
                      value: themeController.isDarkMode.value,
                      onChanged: (value) {
                        themeController.toggleTheme();
                      },
                      activeColor: MyColors.primaryColor,
                    )),
              ),
              _buildSettingItem(
                'Download over Wi-Fi only',
                Icons.wifi,
                trailing: Switch(
                  value: _downloadOverWifi,
                  onChanged: (value) {
                    setState(() {
                      _downloadOverWifi = value;
                    });
                  },
                  activeColor: MyColors.primaryColor,
                ),
              ),
              _buildSettingItem(
                'Text Size',
                Icons.text_fields,
                subtitle: Slider(
                  activeColor: MyColors.primaryColor,
                  value: _textSize,
                  min: 12.0,
                  max: 24.0,
                  divisions: 4,
                  label: _textSize.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      _textSize = value;
                    });
                  },
                ),
              ),
              _buildSettingItem(
                'Language',
                Icons.language,
                trailing: DropdownButton<String>(
                  value: _selectedLanguage,
                  underline: Container(),
                  items: <String>[
                    'English',
                    'Spanish',
                    'French',
                    'German',
                    'Japanese',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyLarge?.color),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedLanguage = newValue;
                      });
                    }
                  },
                ),
              ),
            ]),
            Divider(height: 1, thickness: 1, color: MyColors.lightgreyline),
            _buildSettingsSection('Support', [
              _buildSettingItem(
                'Help Center',
                Icons.help,
                trailing: Icon(Icons.chevron_right, color: MyColors.grey),
                onTap: () {},
              ),
              _buildSettingItem(
                'Report a Bug',
                Icons.bug_report,
                trailing: Icon(Icons.chevron_right, color: MyColors.grey),
                onTap: () {},
              ),
              _buildSettingItem(
                'Privacy Policy',
                Icons.privacy_tip,
                trailing: Icon(Icons.chevron_right, color: MyColors.grey),
                onTap: () {},
              ),
              _buildSettingItem(
                'Terms of Service',
                Icons.description,
                trailing: Icon(Icons.chevron_right, color: MyColors.grey),
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(foregroundColor: MyColors.red),
                onPressed: () {},
                child: const Text('Log Out'),
              ),
            ),
            Center(
              child: Text(
                'App Version 1.0.3',
                style: TextStyle(
                  color: Get.isDarkMode ? MyColors.neutralGray : MyColors.grey,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        ...items,
      ],
    );
  }

  Widget _buildSettingItem(
    String title,
    IconData icon, {
    Widget? trailing,
    Widget? subtitle,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
                if (trailing != null) trailing,
              ],
            ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 8),
                child: subtitle,
              ),
          ],
        ),
      ),
    );
  }
}
