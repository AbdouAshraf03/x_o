import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color deepSpaceDark = Color(0xFF0D0E14);

  static const Color deepSpaceLight = Color(0xFF1A1C2C);

  static const Color glassPanelSurface = Color(0x99191B2C);

  static const Color inputBackground = Color(0x4D000000);

  static const Color coreCyan = Color(0xFF22D3EE);

  static const Color actionBlue = Color(0xFF2563EB);

  static const Color deepBlueAccent = Color(0xFF06B6D4);

  static const Color lightestCyan = Color(0xFFCFFAFE);

  static const Color gradientStart = Color(0xFF00D2FF);

  static const Color gradientEnd = Color(0xFF0099FF);

  static const Color buttonShadow = Color(0x800099FF);

  static const LinearGradient actionGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [gradientStart, gradientEnd],
  );

  static const Color glassBorder = Color(0x3300FFFF);

  static const Color grid = Color(0x0D00FFFF);

  static const Color inputFocusGlow = Color(0xCC00FFFF);

  static const Color decorativeCyanCorner = Color(0x4D06B6D4);

  static const Color primaryText = Color(0xFFE2E8F0);

  static const Color white = Color(0xFFFFFFFF);

  static const Color statusGreen = Color(0xFF22C55E);

  static const Color mutedPlaceholder = Color(0xFF164E63);

  static const Color lowContrastText = Color(0x66FFFFFF);

  static const Color ultraLowContrast = Color(0x33FFFFFF);

  static const Color mutedCyan = Color(0x8022D3EE);
}
