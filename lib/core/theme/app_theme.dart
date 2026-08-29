import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';
import 'typography.dart';

/// Application Theme Configuration
/// Provides Light and Dark theme configurations
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  /// Light Theme Configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      primaryColor: AppColors.coreCyan,
      scaffoldBackgroundColor: AppColors.deepSpaceLight,

      colorScheme: const ColorScheme.light(
        primary: AppColors.coreCyan,
        secondary: AppColors.actionBlue,
        error: AppColors.actionBlue,
        surface: AppColors.deepSpaceLight,
        onPrimary: AppColors.deepSpaceDark,
        onSecondary: AppColors.white,
        onError: AppColors.white,
        onSurface: AppColors.primaryText,
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.deepSpaceLight,
        foregroundColor: AppColors.primaryText,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: AppTypography.h2.copyWith(color: AppColors.primaryText),
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTypography.h1.copyWith(color: AppColors.primaryText),
        displayMedium: AppTypography.h2.copyWith(color: AppColors.primaryText),
        displaySmall: AppTypography.h3.copyWith(color: AppColors.primaryText),
        headlineMedium: AppTypography.h4.copyWith(color: AppColors.primaryText),
        bodyLarge: AppTypography.bodyLarge.copyWith(
          color: AppColors.primaryText,
        ),
        bodyMedium: AppTypography.bodyMedium.copyWith(
          color: AppColors.lowContrastText,
        ),
        bodySmall: AppTypography.bodySmall.copyWith(
          color: AppColors.lowContrastText,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.glassBorder),
        ),
        color: AppColors.glassPanelSurface,
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,

        hintStyle: const TextStyle(color: AppColors.mutedPlaceholder),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.glassBorder),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.glassBorder),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.coreCyan, width: 2),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.actionBlue),
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.actionBlue,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.button,
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.coreCyan,
          textStyle: AppTypography.button,
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: AppColors.primaryText, size: 24),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.grid,
        thickness: 1,
        space: 1,
      ),
    );
  }

  /// Dark Theme Configuration
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      primaryColor: AppColors.coreCyan,
      scaffoldBackgroundColor: AppColors.deepSpaceDark,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.coreCyan,
        secondary: AppColors.actionBlue,
        error: AppColors.actionBlue,
        surface: AppColors.deepSpaceDark,
        onPrimary: AppColors.deepSpaceDark,
        onSecondary: AppColors.white,
        onError: AppColors.white,
        onSurface: AppColors.primaryText,
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.deepSpaceDark,
        foregroundColor: AppColors.primaryText,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: AppTypography.h2.copyWith(color: AppColors.primaryText),
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTypography.h1.copyWith(color: AppColors.primaryText),
        displayMedium: AppTypography.h2.copyWith(color: AppColors.primaryText),
        displaySmall: AppTypography.h3.copyWith(color: AppColors.primaryText),
        headlineMedium: AppTypography.h4.copyWith(color: AppColors.primaryText),
        bodyLarge: AppTypography.bodyLarge.copyWith(
          color: AppColors.primaryText,
        ),
        bodyMedium: AppTypography.bodyMedium.copyWith(
          color: AppColors.lowContrastText,
        ),
        bodySmall: AppTypography.bodySmall.copyWith(
          color: AppColors.lowContrastText,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.glassBorder),
        ),
        color: AppColors.glassPanelSurface,
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,

        hintStyle: const TextStyle(color: AppColors.mutedPlaceholder),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.glassBorder),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.glassBorder),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.inputFocusGlow,
            width: 2,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.actionBlue),
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.actionBlue,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTypography.button,
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.coreCyan,
          textStyle: AppTypography.button,
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: AppColors.primaryText, size: 24),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.grid,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
