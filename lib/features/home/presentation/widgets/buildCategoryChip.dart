import 'package:carraze/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

Widget buildCategoryChip({
  required String category,
  required Function(String) onSelected,
  required String? selectedCategory,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: ChoiceChip(
      label: CustomText(txt: category, fontSize: 14, color: Colors.white),
      selected: selectedCategory == category,
      onSelected: (selected) {
        onSelected(category);
      },
      backgroundColor: Colors.grey[800],
      selectedColor: Color(0xFF1C2526).withOpacity(0.7),
    ),
  );
}
