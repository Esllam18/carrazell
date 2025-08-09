import 'package:carraze/core/widgets/custom_button.dart';
import 'package:carraze/core/widgets/custom_text_form_field.dart';
import 'package:carraze/features/auth/logic/cubit/auth_cubit.dart';
import 'package:carraze/features/auth/logic/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ReastPasswordState();
}

class _ReastPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Builder(
        builder: (context) => Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/car1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is ResetPasswordSuccess) {
                Navigator.pop(context); // Close loading
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  text: 'Password reset email sent. Please check your inbox.',
                );
              } else if (state is AuthError) {
                Navigator.pop(context); // Close loading
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  text: state.message,
                );
              } else if (state is AuthLoading) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.loading,
                  text: 'Please wait...',
                  barrierDismissible: false,
                );
              }
            },
            builder: (context, state) {
              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        const Text(
                          'Reset Password',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 40),
                        CustomTextFormField(
                          labelText: 'Email',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          controller: _emailController,
                          hint: 'Email',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),

                        CustomButton(
                          backgroundColor: const Color(0xFF2E4A62),
                          content: const Text(
                            'Reset Password',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().resetPassword(
                                email: _emailController.text.trim(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
