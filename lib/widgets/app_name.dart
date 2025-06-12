import 'package:flutter/material.dart';
import 'package:sayohat/theme/app_colors.dart';

class AppName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Sayohat',
      style: TextStyle(
        color: AppColors.primaryGreen,
        fontSize: 35.0,
        fontFamily: 'Comfortaa',
      ),
    );
  }
}
