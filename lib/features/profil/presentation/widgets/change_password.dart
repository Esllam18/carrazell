import 'package:carraze/core/widgets/custom_snackbar.dart';
import 'package:carraze/core/widgets/custom_text.dart';
import 'package:carraze/core/widgets/custom_text_field.dart';
import 'package:carraze/core/widgets/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          txt: 'Change Password',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/car1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                CustomText(
                  txt: 'Update Your Password',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  controller: _currentPasswordController,
                  hintText: 'Current Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Enter your current password';
                    if (value.length < 6)
                      return 'Password must be at least 6 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _newPasswordController,
                  hintText: 'New Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Enter a new password';
                    if (value.length < 6)
                      return 'Password must be at least 6 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm New Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Confirm your new password';
                    if (value != _newPasswordController.text)
                      return 'Passwords do not match';
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                CustomButton(
                  backgroundColor: const Color(0xFF2E4A62),
                  content: CustomText(
                    txt: 'Save Password',
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      CustomSnackBar.show(
                        context,
                        message: 'Password updated successfully!',
                        type: SnackBarType.success,
                      );
                      context.pop();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
