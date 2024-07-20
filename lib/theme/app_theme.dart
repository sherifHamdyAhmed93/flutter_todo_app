import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_colors.dart';

class AppTheme{

  static final ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      color: AppColors.primaryColor,
      elevation: 0
    ),
    scaffoldBackgroundColor: AppColors.backgroundLightColor,
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        color: AppColors.whiteColor,
        fontSize: 22,
        fontWeight: FontWeight.bold
      ),

      titleMedium: GoogleFonts.poppins(
          color: AppColors.primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold
      ),

      bodyMedium:  GoogleFonts.roboto(
          color: AppColors.blackColor,
          fontSize: 15,
          fontWeight: FontWeight.bold
      )

    ),

  );

}