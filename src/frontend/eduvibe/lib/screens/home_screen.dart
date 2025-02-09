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
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Center(child: Text("🏠 Accueil", style: TextStyle(fontSize: 24))),
    const CoursesScreen(),
    const AssignmentsScreen(),
    const CommunityScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: AppBar(
          title: const Text("EduVibe"),
          actions: [ProfileMenu()],
        ),
      ),
      body: IndexedStack(index: _selectedIndex, children: _screens),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatScreen()),
        ),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.chat),
      ),
      bottomNavigationBar: BottomNav(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
