import 'package:flutter/material.dart';
import 'app_constants.dart';

class AppTheme {
  var _lightTheme = ThemeData.light().copyWith(
    primaryColor: AppColors.primary,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      titleTextStyle: TextStyle(color: AppColors.black, fontWeight: AppFontUtils.medium, fontSize: AppFontUtils.headline),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(color: AppColors.black, fontWeight: AppFontUtils.medium, fontSize: AppFontUtils.headline),
      subtitle1: TextStyle(color: AppColors.black, fontWeight: AppFontUtils.regular, fontSize: AppFontUtils.subtitle),
      bodyText1: TextStyle(color: AppColors.black, fontWeight: AppFontUtils.regular, fontSize: AppFontUtils.body),
      button: TextStyle(color: AppColors.black, fontWeight: AppFontUtils.medium, fontSize: AppFontUtils.button),
      caption: TextStyle(color: AppColors.black, fontWeight: AppFontUtils.regular, fontSize: AppFontUtils.caption),
    ),
  );

  //getters
  ThemeData get theme => _lightTheme;
}
