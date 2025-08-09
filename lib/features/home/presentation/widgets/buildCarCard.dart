import 'package:carraze/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  final String carName;
  final String imagePath;

  final VoidCallback? onTap;

  final String price;
  const CarCard({
    super.key,
    required this.carName,
    required this.imagePath,

    this.onTap,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color(0xFF1C2526).withOpacity(0.8),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12.0),
              ),
              child: Image.network(
                imagePath,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    color: Colors.grey,
                    child: const Center(
                      child: Icon(Icons.error, color: Colors.red),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                txt: carName,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                txt: price,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
