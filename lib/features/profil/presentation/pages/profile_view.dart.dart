import 'package:carraze/core/router/route_names.dart';
import 'package:carraze/core/widgets/custom_button.dart';
import 'package:carraze/core/widgets/custom_snackbar.dart';
import 'package:carraze/core/widgets/custom_text.dart';
import 'package:carraze/features/auth/logic/cubit/auth_cubit.dart';
import 'package:carraze/features/auth/logic/cubit/auth_state.dart';
import 'package:carraze/features/profil/cubit/data_user_cubit.dart';
import 'package:carraze/features/profil/cubit/data_user_state.dart';
import 'package:carraze/features/profil/presentation/widgets/buildProfileOption.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<DataUserCubit>().getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,

        elevation: 0,
        title: const CustomText(
          txt: 'Profile',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (GoRouter.of(context).canPop()) {
              context.pop();
            } else {
              context.go(RouteNames.home);
            }
          },
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
              if (state is DataUserError) {
                CustomSnackBar.show(
                  context,
                  message: state.message,
                  type: SnackBarType.error,
                );
              }
            },
            builder: (context, state) {
              if (state is DataUserLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DataUserLoaded) {
                final user = state.user;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[800],
                      child: user.imageUrl.isNotEmpty
                          ? ClipOval(
                              child: Image.network(
                                user.imageUrl,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 70,
                                    ),
                              ),
                            )
                          : const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 70,
                            ),
                    ),
                    const SizedBox(height: 15),
                    CustomText(
                      txt: user.name,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    CustomText(
                      txt: user.email,
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildProfileOption(
                            context,
                            icon: Icons.info_outline,
                            title: 'Info',
                            onTap: () {
                              // Pass user data to UserProfileInfoPage
                              GoRouter.of(context).push(
                                RouteNames.userIfon,
                                extra: {
                                  'name': user.name,
                                  'email': user.email,
                                  'phone': user.phone,
                                  'uid': user.uid,
                                  'additionalInfo': user.additionalInfo,
                                  'imageUrl': user.imageUrl,
                                },
                              );
                            },
                          ),
                          const Divider(color: Colors.white24, height: 1),
                          buildProfileOption(
                            context,
                            icon: Icons.settings,
                            title: 'Account Settings',
                            onTap: () {
                              GoRouter.of(
                                context,
                              ).push(RouteNames.accountSettings);
                            },
                          ),
                          const Divider(color: Colors.white24, height: 1),
                          buildProfileOption(
                            context,
                            icon: Icons.notifications,
                            title: 'Notifications',
                            onTap: () {
                              CustomSnackBar.show(
                                context,
                                message: 'Notifications toggled',
                                type: SnackBarType.success,
                              );
                            },
                          ),
                          const Divider(color: Colors.white24, height: 1),
                          buildProfileOption(
                            context,
                            icon: Icons.payment,
                            title: 'Payment Methods',
                            onTap: () {
                              GoRouter.of(
                                context,
                              ).push(RouteNames.paymentMethods);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is LogoutSuccess) {
                          Navigator.pop(context); // Close loading dialog
                          QuickAlert.show(
                            context: context,
                            title: 'Success',
                            text: 'Logged out successfully',
                            type: QuickAlertType.success,
                          );
                          GoRouter.of(context).go(RouteNames.login);
                        } else if (state is AuthError) {
                          Navigator.pop(context); // Close loading dialog
                          QuickAlert.show(
                            context: context,
                            title: 'Error',
                            text: 'Failed to logout',
                            type: QuickAlertType.error,
                          );
                        } else if (state is AuthLoading) {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.loading,
                            title: 'Loading...',
                            text: 'Please wait...',
                            barrierDismissible: false,
                            barrierColor: Colors.black.withOpacity(0.5),
                          );
                        }
                      },
                      builder: (context, state) {
                        return CustomButton(
                          backgroundColor: const Color(0xFFF44336),
                          content: const CustomText(
                            txt: 'Logout',
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          onPressed: () {
                            context.read<AuthCubit>().logout();
                          },
                        );
                      },
                    ),
                  ],
                );
              } else if (state is DataUserError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        txt: 'Error: ${state.message}',
                        fontSize: 18,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        backgroundColor: const Color(0xFF2E4A62),
                        content: const CustomText(
                          txt: 'Retry',
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        onPressed: () {
                          context.read<DataUserCubit>().getUserInfo();
                        },
                      ),
                    ],
                  ),
                );
              }
              return const Center(
                child: CustomText(
                  txt: 'No user data available',
                  fontSize: 18,
                  color: Colors.white70,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
