import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LetsGoTheme {
  LetsGoTheme._();

  static Color main = const Color(0xff4376FF);
  static Color lightPurple = const Color(0xffDDE5FB);
  static Color second = const Color(0xffDDE5FB);
  static Color third = const Color(0xff4614a5);
  static Color fourth = const Color(0xfff72685);
  static Color green = const Color(0xff119d0b);
  static Color amber = const Color(0xffF7BF29);
  static Color red = const Color(0xffe00707);
  static Color fifth = const Color(0xff2D2D2D);
  static Color black = const Color(0xff111417);
  static Color lightGrey = const Color(0xff979797);
  static Color white = const Color(0xffffffff);
  static Color transparent = const Color(0x00000000);
  static Color whiteTransparent = const Color(0xC5FDFBFB);

  static TextTheme textTheme = TextTheme(
    headline4: logoTitle,
  );

  static TextStyle logoTitle = TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 55.0,
    letterSpacing: 1.0,
    color: LetsGoTheme.white,
  );

  static TextStyle selectTitle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 25.0,
    letterSpacing: 1.0,
    color: LetsGoTheme.white,
  );

  static TextStyle selectSubTitle = TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 12.0,
    color: LetsGoTheme.white,
  );

  static TextStyle Title = GoogleFonts.lato(
      fontWeight: FontWeight.bold, fontSize: 28, color: LetsGoTheme.black);

  static TextStyle subTitle = GoogleFonts.lato(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: LetsGoTheme.black,
  );

  static TextStyle loginTitle = GoogleFonts.lato(
    fontWeight: FontWeight.w900,
    fontSize: 35,
    letterSpacing: 0.7,
    color: LetsGoTheme.white,
  );

  static TextStyle resetPasswordTitle = GoogleFonts.lato(
    fontWeight: FontWeight.w800,
    fontSize: 22.5,
    letterSpacing: 0.7,
    color: LetsGoTheme.white,
  );

  static TextStyle bigTitle = GoogleFonts.lato(
    fontWeight: FontWeight.w800,
    fontSize: 28,
    letterSpacing: 0.7,
    color: LetsGoTheme.black,
  );

  static TextStyle reservation = GoogleFonts.lato(
    fontWeight: FontWeight.w800,
    fontSize: 20,
    letterSpacing: 0.7,
    color: LetsGoTheme.black,
  );

  static TextStyle search = GoogleFonts.lato(
    fontSize: 14.0,
    color: LetsGoTheme.black,
  );

  static TextStyle sliderTitle = GoogleFonts.lato(
    fontSize: 20,
    color: LetsGoTheme.black,
    fontWeight: FontWeight.w800,
  );

  static TextStyle communityTitle = GoogleFonts.lato(
    fontSize: 24,
    color: LetsGoTheme.white,
    fontWeight: FontWeight.w900,
  );

  static TextStyle communitySubTitle = GoogleFonts.lato(
    fontSize: 14,
    color: LetsGoTheme.white,
  );

  static TextStyle calendarMonth = GoogleFonts.lato(
    fontSize: 24,
    color: Colors.amber,
    fontWeight: FontWeight.w900,
  );

  static TextStyle calendarDate = GoogleFonts.lato(
    fontSize: 24,
    color: Colors.black,
    fontWeight: FontWeight.w700,
  );

  static TextStyle connexion = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: LetsGoTheme.main,
  );
}
