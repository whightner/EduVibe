import 'package:flutter/material.dart';
import '../auth_service.dart';
import '../login_screen.dart';
import 'edit_profile_screen.dart';
import 'settings_screen.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.person, size: 30),
      onSelected: (value) {
        if (value == 0) {
          // Navigate to Edit Profile
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditProfileScreen()),
          );
        } else if (value == 1) {
          // Navigate to Settings
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsScreen()),
          );
        } else if (value == 2) {
          _logout(context);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 0,
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text("Edit Profile"),
          ),
        ),
        const PopupMenuItem(
          value: 1,
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
        ),
        const PopupMenuItem(
          value: 2,
          child: ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
          ),
        ),
      ],
    );
  }

  void _logout(BuildContext context) async {
    await AuthService().signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
