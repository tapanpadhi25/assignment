import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomTheme {
  static ThemeData? getTheme(isLightMode) {
    return isLightMode
        ? ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: const Color(0xff2FDF84),
      secondaryHeaderColor: const Color(0xffFFFFFF),
      scaffoldBackgroundColor: const Color(0xffFFFFFF),
      appBarTheme: const AppBarTheme(color: Color(0xffFFFFFF)), //0xff7300e6  0xff180fd1
      textTheme: TextTheme(
        titleSmall: GoogleFonts.quicksand(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xff323232)),
        titleMedium: GoogleFonts.quicksand(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: const Color(0xff323232),
          textStyle: const TextStyle(overflow: TextOverflow.visible),
        ),
        titleLarge: GoogleFonts.quicksand(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xff323232),
            textStyle: const TextStyle(overflow: TextOverflow.visible)),
      ),
    )
        : ThemeData(
      textTheme: const TextTheme(
        titleSmall: TextStyle(color: Colors.black, fontSize: 14),
        titleMedium: TextStyle(color: Colors.black, fontSize: 16),
        titleLarge: TextStyle(color: Colors.black, fontSize: 22),
      ),
    );
  }

}
