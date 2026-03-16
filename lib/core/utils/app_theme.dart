import 'package:flutter/material.dart';

/// Holds all color constants for a single theme variant.
class AppThemeData {
  // ── Login card ────────────────────────────────────────────────────────────
  final Color cardBackground;
  final Color cardBorder;
  final double overlayOpacity;

  final Color titleColor;
  final Color subtitleColor;
  final Color labelColor;

  final Color inputFill;
  final Color inputBorder;
  final Color inputFocusedBorder;
  final Color inputHintText;
  final Color inputTextColor;
  final Color inputIconColor;
  final Color visibilityIconColor;

  final Color dropdownBackground;
  final Color dropdownIcon;
  final Color dropdownItemText;
  final Color dropdownHintText;

  final Color modeButtonBackground;
  final Color modeButtonSelectedBackground;
  final Color modeButtonText;
  final Color modeButtonSelectedText;

  final Color primaryButtonBackground;
  final Color primaryButtonText;
  final Color primaryButtonShadow;

  final Color usbLabelColor;

  final Color logoBadgeBackground;
  final Color logoBadgeBorder;

  // ── Global layout ─────────────────────────────────────────────────────────
  final Color pageBackground;      // Scaffold background
  final Color surfaceColor;        // Cards, panels on the page
  final Color textOnSurface;       // Primary text on surfaceColor
  final Color textSecondary;       // Secondary/muted text
  final Color loadingIndicatorColor;

  // ── AppBar ────────────────────────────────────────────────────────────────
  final Color appBarBackground;
  final Color appBarForeground;    // Title & icon color
  final Color appBarAccent;        // Accent subtitle (e.g. system mode text)
  final Color iconBoxBackground;   // Small icon container in AppBar
  final Color iconBoxIcon;         // Icon inside the box

  // ── Side Menu ─────────────────────────────────────────────────────────────
  final Color menuBackground;
  final Color menuBorder;
  final Color menuSelectedBackground;
  final Color menuSelectedIcon;
  final Color menuSelectedText;
  final Color menuUnselectedIcon;
  final Color menuUnselectedText;
  final Color sectionHeaderColor;

  // ── DateTimeWidget ────────────────────────────────────────────────────────
  final Color dateTimeGradientStart;
  final Color dateTimeGradientEnd;
  final Color dateTimeBorder;
  final Color dateTimeClockColor;
  final Color dateTimeDateColor;
  final Color dateTimeIconBackground;

  // ── Generic card / container ──────────────────────────────────────────────
  final Color cardSurface;         // Card background (same as surfaceColor usually)
  final Color cardBorderColor;     // Card border

  // ── Form / Dialog ─────────────────────────────────────────────────────────
  final Color dialogBackground;
  final Color dividerColor;

  const AppThemeData({
    // Login
    required this.cardBackground,
    required this.cardBorder,
    required this.overlayOpacity,
    required this.titleColor,
    required this.subtitleColor,
    required this.labelColor,
    required this.inputFill,
    required this.inputBorder,
    required this.inputFocusedBorder,
    required this.inputHintText,
    required this.inputTextColor,
    required this.inputIconColor,
    required this.visibilityIconColor,
    required this.dropdownBackground,
    required this.dropdownIcon,
    required this.dropdownItemText,
    required this.dropdownHintText,
    required this.modeButtonBackground,
    required this.modeButtonSelectedBackground,
    required this.modeButtonText,
    required this.modeButtonSelectedText,
    required this.primaryButtonBackground,
    required this.primaryButtonText,
    required this.primaryButtonShadow,
    required this.usbLabelColor,
    required this.logoBadgeBackground,
    required this.logoBadgeBorder,
    // Global layout
    required this.pageBackground,
    required this.surfaceColor,
    required this.textOnSurface,
    required this.textSecondary,
    required this.loadingIndicatorColor,
    // AppBar
    required this.appBarBackground,
    required this.appBarForeground,
    required this.appBarAccent,
    required this.iconBoxBackground,
    required this.iconBoxIcon,
    // Side Menu
    required this.menuBackground,
    required this.menuBorder,
    required this.menuSelectedBackground,
    required this.menuSelectedIcon,
    required this.menuSelectedText,
    required this.menuUnselectedIcon,
    required this.menuUnselectedText,
    required this.sectionHeaderColor,
    // DateTime
    required this.dateTimeGradientStart,
    required this.dateTimeGradientEnd,
    required this.dateTimeBorder,
    required this.dateTimeClockColor,
    required this.dateTimeDateColor,
    required this.dateTimeIconBackground,
    // Generic card
    required this.cardSurface,
    required this.cardBorderColor,
    // Form / Dialog
    required this.dialogBackground,
    required this.dividerColor,
  });
}

/// Static class providing theme data for Dark (green) and Light (orange) modes.
class AppTheme {
  AppTheme._();

  // ─── DARK GREEN THEME ────────────────────────────────────────────────────
  static const AppThemeData dark = AppThemeData(
    // Login
    cardBackground: Color(0xFF1E241E),
    cardBorder: Color(0x1AFFFFFF),
    overlayOpacity: 0.40,
    titleColor: Colors.white,
    subtitleColor: Color(0x8AFFFFFF),
    labelColor: Color(0xFF69F0AE),
    inputFill: Color(0x0DFFFFFF),
    inputBorder: Color(0x3DFFFFFF),
    inputFocusedBorder: Colors.green,
    inputHintText: Color(0x3DFFFFFF),
    inputTextColor: Colors.white,
    inputIconColor: Color(0x8AFFFFFF),
    visibilityIconColor: Color(0x8AFFFFFF),
    dropdownBackground: Color(0xFF1E241E),
    dropdownIcon: Colors.green,
    dropdownItemText: Colors.white,
    dropdownHintText: Color(0x8AFFFFFF),
    modeButtonBackground: Colors.transparent,
    modeButtonSelectedBackground: Color(0xFF00C853),
    modeButtonText: Color(0x8AFFFFFF),
    modeButtonSelectedText: Colors.black,
    primaryButtonBackground: Color(0xFF00C853),
    primaryButtonText: Colors.black,
    primaryButtonShadow: Color(0x8000E676),
    usbLabelColor: Color(0x8AFFFFFF),
    logoBadgeBackground: Color(0x99000000),
    logoBadgeBorder: Colors.green,

    // Global layout
    pageBackground: Color(0xFF0F1410),
    surfaceColor: Color(0xFF1E293B),
    textOnSurface: Colors.white,
    textSecondary: Color(0xFFB0BEC5),
    loadingIndicatorColor: Color(0xFF2ECC71),

    // AppBar
    appBarBackground: Color(0xFF0F1410),
    appBarForeground: Colors.white,
    appBarAccent: Color(0xFF2ECC71),
    iconBoxBackground: Color(0xFF1E3A2A),
    iconBoxIcon: Color(0xFF2ECC71),

    // Side Menu
    menuBackground: Color(0xFF0F1410),
    menuBorder: Color(0xFF1E3A2A),
    menuSelectedBackground: Color(0xFF1E3A2A),
    menuSelectedIcon: Color(0xFF2ECC71),
    menuSelectedText: Colors.white,
    menuUnselectedIcon: Color(0xFFB0BEC5),
    menuUnselectedText: Color(0xFFB0BEC5),
    sectionHeaderColor: Color(0xFFB0BEC5),

    // DateTime
    dateTimeGradientStart: Color(0xFF1E3A2A),
    dateTimeGradientEnd: Color(0xFF0F1410),
    dateTimeBorder: Color(0x4D2ECC71),  // 2ECC71 ~30%
    dateTimeClockColor: Color(0xFF2ECC71),
    dateTimeDateColor: Color(0xFFB0BEC5),
    dateTimeIconBackground: Color(0x1A2ECC71), // 2ECC71 10%

    // Generic card
    cardSurface: Color(0xFF1E293B),
    cardBorderColor: Color(0xFF1E3A2A),

    // Form / Dialog
    dialogBackground: Color(0xFF1E293B),
    dividerColor: Color(0xFF1E3A2A),
  );

  // ─── LIGHT ORANGE THEME ──────────────────────────────────────────────────
  static const AppThemeData light = AppThemeData(
    // Login
    cardBackground: Color(0xFFFFFBF5),
    cardBorder: Color(0xFFFFD9A0),
    overlayOpacity: 0.15,
    titleColor: Color(0xFF3E2723),
    subtitleColor: Color(0xFF795548),
    labelColor: Color(0xFFE65100),
    inputFill: Color(0xFFFFF3E0),
    inputBorder: Color(0xFFFFCC80),
    inputFocusedBorder: Color(0xFFF57C00),
    inputHintText: Color(0xFFBCAAA4),
    inputTextColor: Color(0xFF3E2723),
    inputIconColor: Color(0xFF795548),
    visibilityIconColor: Color(0xFF795548),
    dropdownBackground: Color(0xFFFFF8EF),
    dropdownIcon: Color(0xFFF57C00),
    dropdownItemText: Color(0xFF3E2723),
    dropdownHintText: Color(0xFFBCAAA4),
    modeButtonBackground: Colors.transparent,
    modeButtonSelectedBackground: Color(0xFFF57C00),
    modeButtonText: Color(0xFF795548),
    modeButtonSelectedText: Colors.white,
    primaryButtonBackground: Color(0xFFF57C00),
    primaryButtonText: Colors.white,
    primaryButtonShadow: Color(0x60FF8C00),
    usbLabelColor: Color(0xFF795548),
    logoBadgeBackground: Color(0xCCFFFFFF),
    logoBadgeBorder: Color(0xFFF57C00),

    // Global layout
    pageBackground: Color(0xFFFFF8F0),
    surfaceColor: Color(0xFFFFFFFF),
    textOnSurface: Color(0xFF3E2723),
    textSecondary: Color(0xFF8D6E63),
    loadingIndicatorColor: Color(0xFFF57C00),

    // AppBar
    appBarBackground: Color(0xFFFFF8F0),
    appBarForeground: Color(0xFF3E2723),
    appBarAccent: Color(0xFFF57C00),
    iconBoxBackground: Color(0xFFFFE0B2),
    iconBoxIcon: Color(0xFFF57C00),

    // Side Menu
    menuBackground: Color(0xFFFFF3E0),
    menuBorder: Color(0xFFFFD9A0),
    menuSelectedBackground: Color(0xFFFFE0B2),
    menuSelectedIcon: Color(0xFFF57C00),
    menuSelectedText: Color(0xFF3E2723),
    menuUnselectedIcon: Color(0xFF795548),
    menuUnselectedText: Color(0xFF795548),
    sectionHeaderColor: Color(0xFF8D6E63),

    // DateTime
    dateTimeGradientStart: Color(0xFFFFE0B2),
    dateTimeGradientEnd: Color(0xFFFFF3E0),
    dateTimeBorder: Color(0x60F57C00),   // F57C00 ~37%
    dateTimeClockColor: Color(0xFFF57C00),
    dateTimeDateColor: Color(0xFF8D6E63),
    dateTimeIconBackground: Color(0x1AF57C00), // F57C00 10%

    // Generic card
    cardSurface: Color(0xFFFFFFFF),
    cardBorderColor: Color(0xFFFFCC80),

    // Form / Dialog
    dialogBackground: Color(0xFFFFFBF5),
    dividerColor: Color(0xFFFFCC80),
  );

  /// Returns the correct theme based on current platform brightness.
  static AppThemeData of(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark ? dark : light;
  }
}
