import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final IconButton? suffixIcon;
  final VoidCallback? onTap;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    required this.validator,
    required this.controller,
    required this.hint,
    required this.keyboardType,
    this.suffixIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white70),
        hintText: hint, // Added hint text
        filled: true,
        // ignore: deprecated_member_use
        fillColor: const Color(0xFF1C2526).withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        suffixIcon: suffixIcon, // Added suffix icon
      ),
      style: const TextStyle(color: Colors.white),
      validator: validator,
      onTap: onTap, // Added onTap callback
    );
  }
}
// import 'package:flutter/material.dart';

// class CustomTextFormField extends StatelessWidget {
//   final TextEditingController controller;
//   final String hint;
//   final bool obscureText;
//   final TextInputType keyboardType;
//   final String? Function(String?) validator;

//   const CustomTextFormField({
//     super.key,
//     required this.controller,
//     required this.hint,
//     this.obscureText = false,
//     this.keyboardType = TextInputType.text,
//     required this.validator,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       keyboardType: keyboardType,
//       validator: validator,
//       style: const TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: const TextStyle(color: Colors.grey),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         filled: true,
//         fillColor: const Color(0xFF1E1E1E),
//       ),
//     );
//   }
// }
