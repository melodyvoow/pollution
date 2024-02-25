import 'package:flutter/material.dart';

class PollutionColor extends MaterialColor {
  const PollutionColor(super.primary, super.swatch);

  Color get shade20 => this[20]!;

  Color get shade1000 => this[1000]!;
}

class PollutionColors {
  PollutionColors._();

  // static const AptnerColor primary = AptnerColor(
  //   _primaryMainValue,
  //   <int, Color>{
  //     100: Color(0xFFEBF7FF),
  //     200: Color(0xFFE0F3FF),
  //     300: Color(0xFFC7E7FF),
  //     400: Color(0xFF8ACEFF),
  //     500: Color(0xFF4CB4FF),
  //     600: Color(_primaryMainValue),
  //     700: Color(0xFF008BF0),
  //     800: Color(0xFF0079D1),
  //     900: Color(0xff0061A8),
  //     1000: Color(0xff004280),
  //   },
  // );
  // static const int _primaryMainValue = 0xFF0D99FF;

  // static const AptnerColor neutral = AptnerColor(
  //   _neutralMainValue,
  //   <int, Color>{
  //     100: Color(0xFFF9F9F9),
  //     200: Color(0xFFF5F5F5),
  //     300: Color(0xFFEEEEEE),
  //     400: Color(0xFFDDDDDD),
  //     500: Color(0xFFBBBBBB),
  //     600: Color(_neutralMainValue),
  //     700: Color(0xFF777777),
  //     800: Color(0xFF666666),
  //     900: Color(0xFF555555),
  //     1000: Color(0xFF333333),
  //   },
  // );
  // static const int _neutralMainValue = 0xFF999999;

  // static const AptnerColor red = AptnerColor(
  //   _redMainValue,
  //   <int, Color>{
  //     100: Color(0xFFFEF1F1),
  //     200: Color(0xFFFDE7E7),
  //     300: Color(0xFFFBD5D5),
  //     400: Color(0xFFF8B9B9),
  //     500: Color(0xFFF49494),
  //     600: Color(0xFFF17474),
  //     700: Color(_redMainValue),
  //     800: Color(0xFFE34952),
  //     900: Color(0xFFD0353E),
  //     1000: Color(0xFFB3232C),
  //   },
  // );
  // static const _redMainValue = 0xFFF74F59;

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF222222);

  static const Color purple = Color(0xFF4542D7);
  static const Color redPurple = Color(0xFFB10060);
  static const Color hotPink = Color(0xFFFF2C6B);
  static const Color emerald = Color(0xFF15CDB7);
  static const Color green = Color(0xFF007A8A);
  static const Color skyBlue = Color(0xFF9FE8FF);
  static const Color pink = Color(0xFFFF99B8);
  static const Color whitePink = Color(0xFFFFF6FD);
  static const Color blue = Color(0xFF0079D1);
  static const Color whiteBlue = Color(0xFFF3F9FF);
  static const Color indigo = Color(0xFF001743);

  static const Color grey = Color(0xFFA7ACB4);
  static const Color blueGrey = Color(0xFF626C7B);
  static const Color greenIndigo = Color(0xFF1C3349);
  static const Color purpleIndigo = Color(0xFF24284B);

  static const Color indogoBlue = Color(0xFF2F313E);
  static const Color indogoBlack = Color(0xFF121326);
}
