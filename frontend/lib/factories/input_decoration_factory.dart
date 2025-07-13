import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

InputDecoration inputDecorationFactory(
    IconData iconData,
    String hintText,
    String labelText,
    ) {
  return InputDecoration(
    prefixIcon: Icon(iconData, color: AppColors.primaryGreen),
    hintText: hintText,
    labelText: labelText,
    filled: true,
    fillColor: Colors.white,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
    ),
    border: UnderlineInputBorder(borderSide: BorderSide(width: 1)),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
    ),
  );
}
