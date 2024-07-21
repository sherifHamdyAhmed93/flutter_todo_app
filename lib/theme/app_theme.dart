import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_colors.dart';

class AppTheme{

  static final ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      color: AppColors.primaryColor,
      elevation: 0
    ),
    bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(15), topLeft: Radius.circular(15)),
    )),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.whiteColor,width: 4),
        borderRadius: BorderRadius.circular(30)
      )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.unselectedIconColor,
      showUnselectedLabels: false,
        backgroundColor: Colors.transparent
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
        bodyLarge: GoogleFonts.inter(
            color: AppColors.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w400),
        bodyMedium:  GoogleFonts.roboto(
          color: AppColors.blackColor,
            fontSize: 18,
            fontWeight: FontWeight.bold),
        bodySmall: GoogleFonts.inter(
            color: AppColors.hintColor,
            fontSize: 18,
            fontWeight: FontWeight.w400)

    ),

  );

}