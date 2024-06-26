import 'package:flutter/cupertino.dart';

class AppColors {
  static LinearGradient primaryGradient = LinearGradient(
    colors: [primary, const Color(0xFFFF5AAC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static Color primary = const Color(0xFF6A73);
  static Color primarySoft = const Color(0xFFFFCADE);
  static Color primaryExtraSoft = const Color(0xFFEFF3FC);
  static Color orangeColor = const Color(0xFF8C00);
  static Color backgroundColor = const Color(0x1C1E3E);
  static Color secondary = const Color(0xFF1B1F24);
  static Color secondarySoft = const Color(0xFF9D9D9D);
  static Color secondaryExtraSoft = const Color(0xFFE9E9E9);
  static Color error = const Color(0xFFD00E0E);
  static Color success = const Color(0xFF16AE26);
  static Color warning = const Color(0xFFEB8600);
}
