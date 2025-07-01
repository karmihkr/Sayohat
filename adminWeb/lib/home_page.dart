import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('Главная страница')),
    Center(child: Text('Настройки')),
    Center(child: Text('Профиль')),
    Center(child: Text('Помощь')),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Мое приложение'),
      ),
      drawer: isLargeScreen ? null : _buildDrawer(),
      body: isLargeScreen
          ? Row(
              children: [
                Container(
                  width: 200,
                  color: Colors.blue[50],
                  child: _buildDrawerList(),
                ),
                Expanded(child: _pages[_selectedIndex]),
              ],
            )
          : _pages[_selectedIndex],
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: _buildDrawerList(),
    );
  }

  Widget _buildDrawerList() {
    return ListView(
      children: [
        DrawerHeader(
          child: Text('Меню', style: TextStyle(fontSize: 20)),
          decoration: BoxDecoration(color: Colors.blue[100]),
        ),
        _buildNavItem(Icons.home, 'Главная', 0),
        _buildNavItem(Icons.settings, 'Настройки', 1),
        _buildNavItem(Icons.person, 'Профиль', 2),
        _buildNavItem(Icons.help, 'Помощь', 3),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: _selectedIndex == index,
      selectedTileColor: Colors.blue[100],
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });

        if (MediaQuery.of(context).size.width <= 600) {
          Navigator.of(context).pop(); // Закрыть Drawer
        }
      },
    );
  }
}
