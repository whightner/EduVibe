import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import 'profile/profile_menu.dart';
import 'courses_screen.dart';
import 'assignments_screen.dart';
import 'community_screen.dart';
import 'chat/chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Center(child: Text("🏠 Home", style: TextStyle(fontSize: 24))),
    const CoursesScreen(),
    const AssignmentsScreen(),
    const CommunityScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EduVibe"),
        actions: [
          ProfileMenu(), // Profile dropdown menu
        ],
      ),
      body: Stack(
        children: [
          // Main content body
          _screens[_selectedIndex],

          // Chat Icon at the bottom before the BottomNav
          Positioned(
            bottom: 80,  // You can adjust this value to fit your design
            right: 20,   // Adjust the right positioning
            child: FloatingActionButton(
              onPressed: () {
                // Navigate to chat screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()),
                );
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.chat), // Change color as needed
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
