import 'package:flutter/material.dart';

/// A centralized and professional color palette for scalable, maintainable, and
/// consistently-themed Flutter apps. Use AppColors for all color references in
/// your widgets, themes, and styles to ensure easy updates and theming across projects.
class AppColors {
  // ==== BRAND COLORS ====
  static const Color primary = Color(0xFF121417); // Green
  static const Color secondary = Color(0xFF2196F3); // Blue
  static const Color accent = Color(0xFFFF5722); // Orange

  // ==== EXTENDED BRAND COLORS ====
  static const Color primaryDark = Color(0xFF388E3C);
  static const Color primaryLight = Color(0xFFC8E6C9);
  static const Color secondaryDark = Color(0xFF1565C0);
  static const Color secondaryLight = Color(0xFFBBDEFB);
  static const Color accentDark = Color(0xFFE64A19);
  static const Color accentLight = Color(0xFFFFCCBC);

  // ==== NEUTRAL COLORS ====
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color mediumGrey = Color(0xFFBDBDBD);
  static const Color darkGrey = Color(0xFF212121);
  static const Color transparent = Colors.transparent;

  // ==== SEMANTIC COLORS ====
  static const Color error = Color(0xFFF44336);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF03A9F4);

  // ==== BACKGROUND COLORS ====
  static const Color background = Color(0xFFF2F2F2);
  static const Color scaffoldBackground = white;
  static const Color cardBackground = white;
  static const Color inputBackground = lightGrey;
  static const Color modalBackground = Color(0xCCFFFFFF); // semi-transparent

  // ==== TEXT COLORS ====
  static const Color textPrimary = darkGrey;
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFF9E9E9E);
  static const Color link = secondary;
  static const Color textOnPrimary = white;
  static const Color textOnSecondary = white;

  // ==== BUTTON COLORS ====
  static const Color buttonPrimary = primary;
  static const Color buttonSecondary = secondary;
  static const Color buttonAccent = accent;
  static const Color buttonDisabled = mediumGrey;
  static const Color buttonText = white;

  // ==== ICON COLORS ====
  static const Color icon = Color(0xFF616161);
  static const Color iconInactive = mediumGrey;
  static const Color iconActive = primary;

  // ==== BORDER COLORS ====
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderDark = Color(0xFFBDBDBD);
  static const Color focusedBorder = secondary;
  static const Color errorBorder = error;

  // ==== SHADOWS ====
  static const Color shadow = Color(0x29000000); // 16% opacity black
  static const Color shadowLight = Color(0x1F000000); // 12% opacity black

  // ==== UTILITY ====
  /// Returns a color with [opacity] applied (0.0 - 1.0).
  static Color withOpacity(Color color, double opacity) =>
      color.withOpacity(opacity);

  /// Example for dynamic color: get the color for current brightness (theme).
  static Color dynamic({
    required Brightness brightness,
    required Color light,
    required Color dark,
  }) => brightness == Brightness.dark ? dark : light;
}
