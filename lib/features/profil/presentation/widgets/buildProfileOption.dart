import 'dart:ui';

import 'package:carraze/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

Widget buildProfileOption(
  BuildContext context, {
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: const Color(0xFF2E4A62), size: 28),
    title: CustomText(
      txt: title,
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    trailing: const Icon(Icons.chevron_right, color: Colors.white70),
    onTap: onTap,
  );
}
