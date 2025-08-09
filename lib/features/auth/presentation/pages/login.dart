import 'package:carraze/core/router/route_names.dart';
import 'package:carraze/core/widgets/custom_button.dart';
import 'package:carraze/core/widgets/custom_snackbar.dart';
import 'package:carraze/core/widgets/custom_text_form_field.dart';
import 'package:carraze/features/auth/logic/cubit/auth_cubit.dart';
import 'package:carraze/features/auth/logic/cubit/auth_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              if (state is AuthLoading) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.loading,
                  text: 'Please wait...',
                  barrierDismissible: false,
                );
              } else {
                // لو فيه alert مفتوح، اقفله
                Navigator.pop(context);
              }

              if (state is LoginSuccess) {
                CustomSnackBar.show(
                  context,
                  message: "Login successful!",
                  type: SnackBarType.success,
                );
                GoRouter.of(context).replace(RouteNames.home);
              } else if (state is AuthError) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: state.message,
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
                          'Login',
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
                        CustomTextFormField(
                          labelText: 'Password',
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          controller: _passwordController,
                          hint: 'Password',
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          backgroundColor: const Color(0xFF2E4A62),
                          content: const Text(
                            'Login',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthCubit>().login(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [
                            TextButton(
                              onPressed: () {
                                GoRouter.of(
                                  context,
                                ).push(RouteNames.reastpassword);
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            GoRouter.of(context).push(RouteNames.signUp);
                          },
                          child: const Text(
                            'Don\'t have an account? Sign Up',
                            style: TextStyle(color: Colors.white70),
                          ),
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
