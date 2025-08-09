import 'dart:io';
import 'package:carraze/core/router/route_names.dart';
import 'package:carraze/core/widgets/custom_button.dart';
import 'package:carraze/core/widgets/custom_snackbar.dart';
import 'package:carraze/core/widgets/custom_text_form_field.dart';
import 'package:carraze/features/auth/logic/cubit/auth_cubit.dart';
import 'package:carraze/features/auth/logic/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _infoController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _numberController.dispose();
    _infoController.dispose();
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
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );
              } else if (state is! AuthLoading && Navigator.canPop(context)) {
                Navigator.of(context, rootNavigator: true).pop();
              }

              if (state is SignUpSuccess) {
                CustomSnackBar.show(
                  context,
                  message: "Account created successfully!",
                  type: SnackBarType.success,
                );
                GoRouter.of(context).replace(RouteNames.home);
              } else if (state is AuthError) {
                CustomSnackBar.show(
                  context,
                  message: state.message,
                  type: SnackBarType.error,
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
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 40),
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: const Color(0xFF1E1E1E),
                            backgroundImage: _image != null
                                ? FileImage(_image!)
                                : null,
                            child: _image == null
                                ? const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: _emailController,
                          hint: 'Email',
                          keyboardType: TextInputType.emailAddress,
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
                          labelText: 'Email',
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: _passwordController,
                          hint: 'Password',
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
                          labelText: 'Password',
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: _nameController,
                          hint: 'Name',
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          labelText: 'Name',
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: _numberController,
                          hint: 'Phone Number',
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (!RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(value)) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                          labelText: 'Phone Number',
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          controller: _infoController,
                          hint: 'Additional Info',
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some info';
                            }
                            if (value.length < 10) {
                              return 'Info must be at least 10 characters';
                            }
                            return null;
                          },
                          labelText: 'Additional Info',
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          backgroundColor: const Color(0xFF1C2526),
                          content: const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) return;
                            if (_image == null) {
                              CustomSnackBar.show(
                                context,
                                message: 'Please select a profile image',
                                type: SnackBarType.error,
                              );
                              return;
                            }
                            context.read<AuthCubit>().signUp(
                              profileImage: _image!,
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                              name: _nameController.text.trim(),
                              phone: _numberController.text.trim(),
                              additionalInfo: _infoController.text.trim(),
                            );
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
