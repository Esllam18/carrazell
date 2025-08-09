import 'package:flutter/material.dart';

/// A professional, reusable helper for responsive UI design in Flutter.
/// Centralizes breakpoints, layout checks, and utilities for adaptive widgets.
/// Use in any app to ensure consistent responsiveness!
///
/// Example usage:
///   if (ResponsiveHelper.isMobile(context)) ...
///   double padding = ResponsiveHelper.horizontalPadding(context);

class ResponsiveHelper {
  // Common breakpoints (customize as needed)
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;
  static const double desktopBreakpoint = 1440;

  /// Returns the shortest side of the device (width for portrait, height for landscape).
  static double deviceShortestSide(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide;

  /// Returns the device width.
  static double deviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  /// Returns the device height.
  static double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  /// Checks if device is mobile (width < mobileBreakpoint).
  static bool isMobile(BuildContext context) =>
      deviceWidth(context) < mobileBreakpoint;

  /// Checks if device is tablet (mobileBreakpoint <= width < tabletBreakpoint).
  static bool isTablet(BuildContext context) {
    final width = deviceWidth(context);
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  /// Checks if device is desktop (width >= tabletBreakpoint).
  static bool isDesktop(BuildContext context) =>
      deviceWidth(context) >= tabletBreakpoint;

  /// Returns appropriate horizontal padding based on device type.
  static double horizontalPadding(BuildContext context) {
    if (isDesktop(context)) return 64.0;
    if (isTablet(context)) return 32.0;
    return 16.0; // mobile
  }

  /// Returns appropriate grid count (columns) for adaptive layouts.
  static int gridColumns(BuildContext context) {
    if (isDesktop(context)) return 4;
    if (isTablet(context)) return 2;
    return 1;
  }

  /// Returns scaled font size (useful for accessibility).
  static double scaledFontSize(BuildContext context, double fontSize) =>
      MediaQuery.textScalerOf(context).scale(fontSize);

  /// Returns true if in landscape orientation.
  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  /// Returns true if in portrait orientation.
  static bool isPortrait(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait;
}
