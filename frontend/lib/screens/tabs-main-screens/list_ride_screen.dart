import 'package:flutter/material.dart';
//import 'package:sayohat/theme/app_colors.dart';

class ListRideScreen extends StatelessWidget {
  const ListRideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(60),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          "List of rides is in progress",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
