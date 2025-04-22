import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackup/helper/my_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkMode = false;
  bool _downloadOverWifi = true;
  double _textSize = 16.0;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.red,
        title: Text(
          'Settings',
          style: TextStyle(color: MyColors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: MyColors.white),
          onPressed: () {
            Get.back();
            // Navigate back
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
                trailing: const Icon(Icons.chevron_right, color: Colors.red),
                onTap: () {},
              ),
              _buildSettingItem(
                'Change Password',
                Icons.lock,
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {},
              ),
              _buildSettingItem(
                'Linked Accounts',
                Icons.link,
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {},
              ),
            ]),
            const Divider(height: 1, thickness: 1),
            _buildSettingsSection('Learning Preferences', [
              _buildSettingItem(
                'Subject Interests',
                Icons.category,
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {},
              ),
              _buildSettingItem(
                'Learning Schedule',
                Icons.calendar_today,
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {},
              ),
              _buildSettingItem(
                'Difficulty Level',
                Icons.bar_chart,
                trailing: const Text(
                  'Intermediate',
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {},
              ),
            ]),
            const Divider(height: 1, thickness: 1),
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
                ),
              ),
              _buildSettingItem(
                'Dark Mode',
                Icons.dark_mode,
                trailing: Switch(
                  value: _darkMode,
                  onChanged: (value) {
                    setState(() {
                      _darkMode = value;
                    });
                  },
                ),
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
                ),
              ),
              _buildSettingItem(
                'Text Size',
                Icons.text_fields,
                subtitle: Slider(
                  activeColor: MyColors.red,
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
                      child: Text(value),
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
            const Divider(height: 1, thickness: 1),
            _buildSettingsSection('Support', [
              _buildSettingItem(
                'Help Center',
                Icons.help,
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {},
              ),
              _buildSettingItem(
                'Report a Bug',
                Icons.bug_report,
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {},
              ),
              _buildSettingItem(
                'Privacy Policy',
                Icons.privacy_tip,
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {},
              ),
              _buildSettingItem(
                'Terms of Service',
                Icons.description,
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
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
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
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
              color: MyColors.red,
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
                Icon(icon, color: MyColors.red),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(title, style: const TextStyle(fontSize: 16)),
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
