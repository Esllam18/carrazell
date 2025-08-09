import 'package:carraze/core/router/route_names.dart';
import 'package:carraze/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeViewBody extends StatelessWidget {
  const WelcomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand, // Ensures the stack fills the entire screen
      children: [
        Image.asset(
          "assets/car1.jpg", // Replace with your welcome background image
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        // Background image
        Container(
          color: Colors.black.withOpacity(
            0.5,
          ), // Dark overlay for better text contrast
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomButton(
                    backgroundColor: const Color(0xFF1C2526),
                    content: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_forward, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Login', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    onPressed: () {
                      GoRouter.of(context).push(RouteNames.login);
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    backgroundColor: const Color(0xFF2E4A62),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_add, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Sign Up', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    onPressed: () {
                      GoRouter.of(context).push(RouteNames.signUp);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
