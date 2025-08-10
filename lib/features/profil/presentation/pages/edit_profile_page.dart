import 'package:carraze/core/models/user_model.dart';
import 'package:carraze/core/router/route_names.dart';
import 'package:carraze/core/widgets/custom_text.dart';
import 'package:carraze/core/widgets/custom_text_field.dart';
import 'package:carraze/core/widgets/custom_button.dart';
import 'package:carraze/features/profil/cubit/data_user_cubit.dart';
import 'package:carraze/features/profil/cubit/data_user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';

class EditProfilePage extends StatefulWidget {
  final UserModel? user;

  const EditProfilePage({super.key, this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _additionalInfoController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _additionalInfoController = TextEditingController();

    // Fetch current user data
    final cubit = context.read<DataUserCubit>();
    cubit.getUserInfo();

    cubit.stream.listen((state) {
      if (state is DataUserLoaded) {
        final user = state.user;
        _nameController.text = user.name;
        _emailController.text = user.email;
        _phoneController.text = user.phone;
        _additionalInfoController.text = user.additionalInfo;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _additionalInfoController.dispose();
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
          txt: 'Edit Profile',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go(RouteNames.userIfon),
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
          child: BlocConsumer<DataUserCubit, DataUserState>(
            listener: (context, state) {
              if (state is DataUserUpdated) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: 'Success',
                  text: 'Profile updated successfully!',
                );
              } else if (state is DataUserError) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: 'Error',
                  text: state.message,
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: _nameController,
                      hintText: 'Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your email';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: _phoneController,
                      hintText: 'Phone',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your phone number';
                        }
                        if (!RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(value)) {
                          return 'Enter a valid phone number (e.g., +1234567890)';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: _additionalInfoController,
                      hintText: 'Additional Info',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter additional information';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    state is DataUserLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            backgroundColor: const Color(0xFF2E4A62),
                            content: CustomText(
                              txt: 'Save Changes',
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final userId =
                                    FirebaseAuth.instance.currentUser?.uid;
                                if (userId != null) {
                                  final updatedUser = UserModel(
                                    uid: userId,
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    phone: _phoneController.text,
                                    additionalInfo:
                                        _additionalInfoController.text,
                                    // i dont need change image profile
                                    imageUrl: widget.user?.imageUrl ?? '',
                                  );
                                  context.read<DataUserCubit>().updateUserInfo(
                                    userId,
                                    updatedUser,
                                  );
                                } else {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.error,
                                    title: 'Error',
                                    text: 'User not logged in',
                                  );
                                }
                              }
                            },
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
