import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SnackBarFactory {
  SnackBar createSnackBar(String message) {
    return SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Text(
              message,
              style: TextStyle(
                fontFamily: 'Roboto',
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.w900,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.only(bottom: 50.0),
    );
  }
}

var snackBarFactory = SnackBarFactory();
