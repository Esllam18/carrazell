import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.backgroundColor,
    required this.content,
    required this.onPressed,
    this.style,
  });

  final Color backgroundColor;
  final Widget content;
  final VoidCallback onPressed;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style:
          style ??
          ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
      child: content,
    );
  }
}

// import 'package:flutter/material.dart';
// import '../../core/utils/app_styles.dart';
// import 'custom_text.dart';

// class CustomButton extends StatelessWidget {
//   const CustomButton({
//     super.key,
//     required this.text,
//     required this.onPressed,
//     this.color,
//     this.textColor,
//     this.radius = 12,
//     this.height = 50,
//     this.width,
//     this.icon,
//     this.isLoading = false,
//     this.enabled = true,
//     this.textStyle,
//     this.elevation,
//   });

//   final String text;
//   final VoidCallback onPressed;
//   final Color? color;
//   final Color? textColor;
//   final double radius;
//   final double height;
//   final double? width;
//   final Widget? icon;
//   final bool isLoading;
//   final bool enabled;
//   final TextStyle? textStyle;
//   final double? elevation;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final buttonColor = color ?? theme.colorScheme.primary;
//     final onPrimary = textColor ?? theme.colorScheme.onPrimary;

//     return SizedBox(
//       width: width,
//       height: height,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: enabled ? buttonColor : theme.disabledColor,
//           elevation: elevation,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(radius),
//           ),
//         ),
//         onPressed: enabled && !isLoading ? onPressed : null,
//         child:
//             isLoading
//                 ? SizedBox(
//                   width: 24,
//                   height: 24,
//                   child: CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(onPrimary),
//                     strokeWidth: 2,
//                   ),
//                 )
//                 : Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     if (icon != null) ...[icon!, const SizedBox(width: 8)],
//                     CustomText(
//                       txt: text,
//                       color: onPrimary,
//                       fontWeight: FontWeight.bold,
//                       style: textStyle ?? AppStyles.button(context),
//                     ),
//                   ],
//                 ),
//       ),
//     );
//   }
// }
