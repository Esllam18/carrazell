import 'package:flutter/material.dart';

/// A highly reusable, professional loading widget for Flutter apps.
/// Supports spinner, custom message, fullscreen overlay, and theme adaptation.
/// Use anywhere in your project for consistent loading indicators!
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.message,
    this.color,
    this.size = 36.0,
    this.backgroundColor,
    this.fullscreen = false,
    this.textStyle,
    this.progressIndicator,
    this.margin,
    this.padding,
    this.borderRadius = 16.0,
  });

  /// Optional message to display under the loader.
  final String? message;

  /// The color of the spinner.
  final Color? color;

  /// Size of the spinner.
  final double size;

  /// Background color for overlay/box.
  final Color? backgroundColor;

  /// If true, covers the whole screen with a semi-transparent overlay.
  final bool fullscreen;

  /// Style for the message text.
  final TextStyle? textStyle;

  /// Custom progress indicator widget (overrides default).
  final Widget? progressIndicator;

  /// Margin around the widget (when not fullscreen).
  final EdgeInsetsGeometry? margin;

  /// Padding inside the widget.
  final EdgeInsetsGeometry? padding;

  /// Border radius for the container.
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final indicator =
        progressIndicator ??
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? theme.colorScheme.primary,
          ),
          strokeWidth: 3,
        );

    final loader = Container(
      margin: margin ?? const EdgeInsets.all(24),
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (fullscreen
                // ignore: deprecated_member_use
                ? Colors.black.withOpacity(0.3)
                : theme.cardColor.withOpacity(0.95)),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: size, height: size, child: indicator),
          if (message != null && message!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              textAlign: TextAlign.center,
              style:
                  textStyle ??
                  theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
            ),
          ],
        ],
      ),
    );

    if (fullscreen) {
      return Stack(
        children: [
          Positioned.fill(
            child: Container(
              // ignore: deprecated_member_use
              color: backgroundColor ?? Colors.black.withOpacity(0.3),
            ),
          ),
          Center(child: loader),
        ],
      );
    } else {
      return Center(child: loader);
    }
  }
}
