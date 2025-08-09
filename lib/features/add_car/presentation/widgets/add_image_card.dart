import 'dart:io';
import 'package:carraze/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomAddImageCard extends StatefulWidget {
  final VoidCallback onPickImage;
  final File? image;

  const CustomAddImageCard({Key? key, required this.onPickImage, this.image})
    : super(key: key);

  @override
  State<CustomAddImageCard> createState() => _CustomAddImageCardState();
}

class _CustomAddImageCardState extends State<CustomAddImageCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value * 1.1,
              child: Container(
                width: double.infinity * .9,
                height: MediaQuery.of(context).size.height * .3,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: widget.image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          widget.image!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: CustomText(
                                txt: 'Error loading image: $error',
                                color: Colors.red,
                                fontSize: 14,
                              ),
                            );
                          },
                        ),
                      )
                    : IconButton(
                        icon: CustomText(
                          txt: '+',
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        onPressed: widget.onPickImage,
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
