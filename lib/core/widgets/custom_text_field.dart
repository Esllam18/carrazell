import 'package:flutter/material.dart';
import '../../core/utils/app_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.maxLines = 1,
    this.borderRadius = 12,
    this.filled = true,
    this.fillColor,
    this.enabled = true,
    this.autofocus = false,
    this.style,
    this.contentPadding,
    this.helperText,
  });

  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final int maxLines;
  final double borderRadius;
  final bool filled;
  final Color? fillColor;
  final bool enabled;
  final bool autofocus;
  final TextStyle? style;
  final EdgeInsetsGeometry? contentPadding;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      maxLines: maxLines,
      enabled: enabled,
      autofocus: autofocus,
      style: style ?? AppStyles.bodyMedium(context),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: filled,
        fillColor:
            fillColor ??
            theme.inputDecorationTheme.fillColor ??
            theme.colorScheme.surface,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: theme.dividerColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
        ),
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}








// Usage example:
// CustomTextField(
//   controller: myController,
//   labelText: "Email",
//   hintText: "Enter your email",
//   prefixIcon: Icon(Icons.email),
//   onChanged: (value) => print(value),
//   validator: (value) => value != null && value.isEmpty ? "Required" : null,
//   helperText: "We'll never share your email.",
// )