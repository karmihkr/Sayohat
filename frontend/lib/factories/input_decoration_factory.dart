import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

InputDecoration inputDecorationFactory({
  IconData? prefixIcon,
  String? hintText,
  String? labelText,
  required bool outline,
  Color fillColor = Colors.white
}) {
  return outline ?
  InputDecoration(
    prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: AppColors.primaryGreen) : null,
    hintText: hintText,
    labelText: labelText,
    filled: true,
    fillColor: fillColor,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: AppColors.primaryGreen),
    )
  )
      :
  InputDecoration(
    prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: AppColors.primaryGreen) : null,
    hintText: hintText,
    labelText: labelText,
    filled: true,
    fillColor: fillColor,
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
