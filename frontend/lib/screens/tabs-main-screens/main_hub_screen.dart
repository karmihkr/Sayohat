import 'package:flutter/material.dart';
import 'package:sayohat/screens/tabs-main-screens/find-ride-screens/find_ride_screen.dart';
import 'package:sayohat/screens/tabs-main-screens/add-ride-screens/add_ride_screen.dart';
import 'package:sayohat/screens/tabs-main-screens/list-ride-screens/list_your_ride_screen.dart';
import 'package:sayohat/screens/tabs-main-screens/profile-screens/profile_screen.dart';
import 'package:sayohat/screens/tabs-main-screens/find-ride-screens/list_search_screen.dart';
import 'package:sayohat/theme/app_colors.dart';

class WelcomeHub extends StatefulWidget {
  const WelcomeHub({super.key});

  @override
  State<WelcomeHub> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeHub> {
  int _selectedTab = 0;
  bool _showSearchList = false;

  final List<Widget> _widgetOptions = <Widget>[
    FindRideScreen(onShowSearchList: (show) {}),
    AddRideScreen(),
    ListRideScreen(),
    ProfileScreen(),
  ];

  void onSelectTab(int index) {
    if (_selectedTab == index && _showSearchList) {
      setState(() {
        _showSearchList = false;
      });
      return;
    }
    setState(() {
      _selectedTab = index;
      _showSearchList = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _widgetOptions[0] = FindRideScreen(
      onShowSearchList: (show) {
        setState(() {
          _showSearchList = show;
        });
      },
    );

    return PopScope(
      canPop: false,
      child: Scaffold(
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
            _showSearchList && _selectedTab == 0
                ? const ListSearchRideScreen()
                : _widgetOptions[_selectedTab],
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
              label: 'Your rides',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, color: AppColors.primaryGreen),
              label: 'Profile',
            ),
          ],
          showUnselectedLabels: false,
          backgroundColor: AppColors.backgroundBeige,
          selectedItemColor: AppColors.primaryGreen,
          unselectedItemColor: AppColors.primaryGreen,
          onTap: onSelectTab,
        ),
      ),
    );
  }
}
