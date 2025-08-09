// 📁 lib/core/utils/app_styles.dart
import 'package:flutter/material.dart';

/// Centralized text styles for consistent typography across the app.
///
/// Usage example:
///   Text('Hello', style: AppStyles.heading1(context))
///
/// All styles are theme-adaptive and support dynamic type scaling.
class AppStyles {
  static const String _fontFamily = 'Roboto';

  // Headings
  static TextStyle heading1(BuildContext context) => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.onSurface,
    fontFamily: _fontFamily,
  );

  static TextStyle heading2(BuildContext context) => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.onSurface,
    fontFamily: _fontFamily,
  );

  static TextStyle heading3(BuildContext context) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Theme.of(context).colorScheme.onSurface,
    fontFamily: _fontFamily,
  );

  // Body Text
  static TextStyle bodyLarge(BuildContext context) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onSurface,
    fontFamily: _fontFamily,
  );

  static TextStyle bodyMedium(BuildContext context) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onSurface,
    fontFamily: _fontFamily,
  );

  static TextStyle bodySmall(BuildContext context) => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
    fontFamily: _fontFamily,
  );

  // Muted/Secondary Text
  static TextStyle bodyMuted(BuildContext context) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onSurfaceVariant,
    fontFamily: _fontFamily,
  );

  // Buttons
  static TextStyle button(BuildContext context) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.onPrimary,
    fontFamily: _fontFamily,
  );

  // Captions
  static TextStyle caption(BuildContext context) => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onSurfaceVariant,
    fontFamily: _fontFamily,
  );

  // Links
  static TextStyle link(BuildContext context) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Theme.of(context).colorScheme.primary,
    fontFamily: _fontFamily,
    decoration: TextDecoration.underline,
  );
}
