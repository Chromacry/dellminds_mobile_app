import 'package:dellminds_mobile_app/constants/design_constants.dart';
import 'package:flutter/material.dart';

class Navigation_Bar extends StatefulWidget {
  final int currentIndex;

  const Navigation_Bar({super.key, required this.currentIndex});

  @override
  State<Navigation_Bar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<Navigation_Bar> {
  @override
  Widget build(BuildContext context) {
    final unselectedItemColor = Colors.grey;
    final selectedItemColor = DesignConstants.COLOR_THEMEPINK;

    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      backgroundColor: DesignConstants.COLOR_THEMEPINK,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      onTap: (index) {
        // Navigate to different pages based on the selected tab
        switch (index) {
          case 0:
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            break;
          case 1:
            Navigator.pushNamed(context, '/community');
            break;
          case 2:
            Navigator.pushNamed(context, '/chat');
            break;
          case 3:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'Community',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
