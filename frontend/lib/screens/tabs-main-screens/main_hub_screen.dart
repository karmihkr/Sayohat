import 'package:flutter/material.dart';
import 'package:sayohat/screens/tabs-main-screens/find-ride-screens/find_ride_screen.dart';
import 'package:sayohat/screens/tabs-main-screens/add-ride-screens/add_ride_screen.dart';
import 'package:sayohat/screens/tabs-main-screens/list-ride-screens/list_your_ride_screen.dart';
import 'package:sayohat/screens/tabs-main-screens/profile-screens/profile_screen.dart';
import 'package:sayohat/theme/app_colors.dart';
import 'package:sayohat/l10n/app_localizations.dart';

class WelcomeHub extends StatefulWidget {
  final void Function(Locale) onLocaleChanged;
  const WelcomeHub({super.key, required this.onLocaleChanged});

  @override
  State<WelcomeHub> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeHub> {
  int _selectedTab = 0;
  bool _showSearchList = false;

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
    final loc = AppLocalizations.of(context)!;

    final widgetOptions = <Widget>[
      FindRideScreen(
        onShowSearchList: (show) => setState(() => _showSearchList = show),
      ),
      AddRideScreen(),
      ListRideScreen(),
      ProfileScreen(onLocaleChanged: widget.onLocaleChanged),
    ];

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundGreen,
          automaticallyImplyLeading: false,
          toolbarHeight: 40,
        ),
        body: widgetOptions[_selectedTab],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined, color: AppColors.primaryGreen),
              label: loc.tab_search,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle, color: AppColors.primaryGreen),
              label: loc.tab_add,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_rounded, color: AppColors.primaryGreen),
              label: loc.tab_your_rides,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, color: AppColors.primaryGreen),
              label: loc.tab_profile,
            ),
          ],
          showUnselectedLabels: false,
          backgroundColor: AppColors.backgroundGreen,
          selectedItemColor: AppColors.primaryGreen,
          unselectedItemColor: AppColors.primaryGreen,
          onTap: onSelectTab,
        ),
      ),
    );
  }
}
