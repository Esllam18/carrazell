import 'package:carraze/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

Widget buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(txt: label, fontSize: 16, color: Colors.white70),
        CustomText(
          txt: value,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ],
    ),
  );
}
