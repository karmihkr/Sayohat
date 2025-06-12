import 'package:flutter/material.dart';
import 'package:sayohat/screens/tabs-main-screens/find_ride_screen.dart';
import 'package:sayohat/screens/tabs-main-screens/add_ride_screen.dart';
import 'package:sayohat/screens/tabs-main-screens/list_ride_screen.dart';
import 'package:sayohat/screens/tabs-main-screens/profile_screen.dart';
import 'package:sayohat/theme/app_colors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _selectedTab = 0;

  final List<Widget> _widgetOptions = <Widget>[
    FindRideScreen(),
    AddRideScreen(),
    ListRideScreen(),
    ProfileScreen(),
  ];

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/map-background.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          _widgetOptions[_selectedTab],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined, color: AppColors.primaryGreen),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, color: AppColors.primaryGreen),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded, color: AppColors.primaryGreen),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, color: AppColors.primaryGreen),
            label: 'Profile',
          ),
        ],
        showUnselectedLabels: true,
        backgroundColor: AppColors.backgroundBeige,
        selectedItemColor: AppColors.primaryGreen,
        unselectedItemColor: AppColors.primaryGreen,
        onTap: onSelectTab,
      ),
    );
  }
}
