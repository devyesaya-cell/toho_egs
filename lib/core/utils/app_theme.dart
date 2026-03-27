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

  // ── SCADA specifics ───────────────────────────────────────────────────────
  final Color mapGrid;
  final bool hasGlowEffect;

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
    // SCADA Specifics
    required this.mapGrid,
    required this.hasGlowEffect,
  });
}

/// Static class providing theme data for Dark (SCADA) and Light (SCADA) modes.
class AppTheme {
  AppTheme._();

  // ─── DARK MODE ────────────────────────────────────────────────────────────
  static const AppThemeData dark = AppThemeData(
    // Login
    cardBackground: Color(0xFF1A2235), // surface
    cardBorder: Color(0xFF2A3750),     // border
    overlayOpacity: 0.40,
    titleColor: Color(0xFFFFFFFF),     // textPrimary
    subtitleColor: Color(0xFF8A94A6),  // textSecondary
    labelColor: Color(0xFF00BCD4),     // teal accent
    inputFill: Color(0xFF222B40),      // surfaceVariant
    inputBorder: Color(0xFF2A3040),    // divider
    inputFocusedBorder: Color(0xFF00BCD4),
    inputHintText: Color(0xFF8A94A6),
    inputTextColor: Color(0xFFFFFFFF),
    inputIconColor: Color(0xFF8A94A6),
    visibilityIconColor: Color(0xFF8A94A6),
    dropdownBackground: Color(0xFF1A2235),
    dropdownIcon: Color(0xFF00BCD4),
    dropdownItemText: Color(0xFFFFFFFF),
    dropdownHintText: Color(0xFF8A94A6),
    modeButtonBackground: Colors.transparent,
    modeButtonSelectedBackground: Color(0xFF00BCD4),
    modeButtonText: Color(0xFF8A94A6),
    modeButtonSelectedText: Color(0xFF0D1118),
    primaryButtonBackground: Color(0xFF00BCD4),
    primaryButtonText: Color(0xFF0D1118),
    primaryButtonShadow: Color(0x8000BCD4),
    usbLabelColor: Color(0xFF8A94A6),
    logoBadgeBackground: Color(0x99000000),
    logoBadgeBorder: Color(0xFF00BCD4),

    // Global layout
    pageBackground: Color(0xFF0D1118), // background
    surfaceColor: Color(0xFF1A2235),   // surface
    textOnSurface: Color(0xFFFFFFFF),  // textPrimary
    textSecondary: Color(0xFF8A94A6),  // textSecondary
    loadingIndicatorColor: Color(0xFF00BCD4),

    // AppBar
    appBarBackground: Color(0xFF1C2030), // headerBackground
    appBarForeground: Color(0xFFFFFFFF), // textOnHeader
    appBarAccent: Color(0xFF00BCD4),
    iconBoxBackground: Color(0xFF222B40), // surfaceVariant
    iconBoxIcon: Color(0xFF00BCD4),

    // Side Menu
    menuBackground: Color(0xFF0D1118), // background
    menuBorder: Color(0xFF2A3750),     // border
    menuSelectedBackground: Color(0xFF1C2030), // headerBackground
    menuSelectedIcon: Color(0xFF00BCD4),
    menuSelectedText: Color(0xFFFFFFFF),
    menuUnselectedIcon: Color(0xFF8A94A6),
    menuUnselectedText: Color(0xFF8A94A6),
    sectionHeaderColor: Color(0xFF8A94A6),

    // DateTime
    dateTimeGradientStart: Color(0xFF1A2235), // surface
    dateTimeGradientEnd: Color(0xFF0D1118),   // background
    dateTimeBorder: Color(0x4D00BCD4),
    dateTimeClockColor: Color(0xFF00BCD4),
    dateTimeDateColor: Color(0xFF8A94A6),
    dateTimeIconBackground: Color(0x1A00BCD4),

    // Generic card
    cardSurface: Color(0xFF1A2235),      // surface
    cardBorderColor: Color(0xFF2A3750),  // border

    // Form / Dialog
    dialogBackground: Color(0xFF1A2235), // surface
    dividerColor: Color(0xFF2A3040),     // divider

    // Scada Specifics
    mapGrid: Color(0xFF162032),
    hasGlowEffect: true,
  );

  // ─── LIGHT MODE ───────────────────────────────────────────────────────────
  static const AppThemeData light = AppThemeData(
    // Login
    cardBackground: Color(0xFFFFFFFF), // surface
    cardBorder: Color(0xFF00BCD4),     // border
    overlayOpacity: 0.15,
    titleColor: Color(0xFF1A1A2E),     // textPrimary
    subtitleColor: Color(0xFF7A8290),  // textSecondary
    labelColor: Color(0xFF00BCD4),
    inputFill: Color(0xFFF5F7FA),      // surfaceVariant
    inputBorder: Color(0xFFD0D4DA),    // divider
    inputFocusedBorder: Color(0xFF00BCD4),
    inputHintText: Color(0xFF7A8290),
    inputTextColor: Color(0xFF1A1A2E),
    inputIconColor: Color(0xFF7A8290),
    visibilityIconColor: Color(0xFF7A8290),
    dropdownBackground: Color(0xFFFFFFFF),
    dropdownIcon: Color(0xFF00BCD4),
    dropdownItemText: Color(0xFF1A1A2E),
    dropdownHintText: Color(0xFF7A8290),
    modeButtonBackground: Colors.transparent,
    modeButtonSelectedBackground: Color(0xFF00BCD4),
    modeButtonText: Color(0xFF7A8290),
    modeButtonSelectedText: Color(0xFFFFFFFF),
    primaryButtonBackground: Color(0xFF00BCD4),
    primaryButtonText: Color(0xFFFFFFFF),
    primaryButtonShadow: Color(0x6000BCD4),
    usbLabelColor: Color(0xFF7A8290),
    logoBadgeBackground: Color(0xCCFFFFFF),
    logoBadgeBorder: Color(0xFF00BCD4),

    // Global layout
    pageBackground: Color(0xFFE8ECF0), // background
    surfaceColor: Color(0xFFFFFFFF),   // surface
    textOnSurface: Color(0xFF1A1A2E),  // textPrimary
    textSecondary: Color(0xFF7A8290),  // textSecondary
    loadingIndicatorColor: Color(0xFF00BCD4),

    // AppBar
    appBarBackground: Color(0xFFFFFFFF), // headerBackground
    appBarForeground: Color(0xFF1A1A2E), // textOnHeader
    appBarAccent: Color(0xFF00BCD4),
    iconBoxBackground: Color(0xFFF5F7FA), // surfaceVariant
    iconBoxIcon: Color(0xFF00BCD4),

    // Side Menu
    menuBackground: Color(0xFFFFFFFF), 
    menuBorder: Color(0xFFD0D4DA),     // divider
    menuSelectedBackground: Color(0xFFF5F7FA), // surfaceVariant
    menuSelectedIcon: Color(0xFF00BCD4),
    menuSelectedText: Color(0xFF1A1A2E),
    menuUnselectedIcon: Color(0xFF7A8290),
    menuUnselectedText: Color(0xFF7A8290),
    sectionHeaderColor: Color(0xFF7A8290),

    // DateTime
    dateTimeGradientStart: Color(0xFFF5F7FA), // surfaceVariant
    dateTimeGradientEnd: Color(0xFFFFFFFF),   // surface
    dateTimeBorder: Color(0x6000BCD4),
    dateTimeClockColor: Color(0xFF00BCD4),
    dateTimeDateColor: Color(0xFF7A8290),
    dateTimeIconBackground: Color(0x1A00BCD4),

    // Generic card
    cardSurface: Color(0xFFFFFFFF),   // surface
    cardBorderColor: Color(0xFF00BCD4), // border

    // Form / Dialog
    dialogBackground: Color(0xFFFFFFFF), // surface
    dividerColor: Color(0xFFD0D4DA),     // divider

    // Scada Specifics
    mapGrid: Color(0xFFD5DCE4),
    hasGlowEffect: false,
  );

  /// Returns the correct theme based on current platform brightness.
  static AppThemeData of(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark ? dark : light;
  }
}
