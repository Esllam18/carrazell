import 'package:carraze/core/router/route_names.dart';
import 'package:carraze/core/widgets/custom_text.dart';
import 'package:carraze/core/widgets/custom_button.dart';
import 'package:carraze/features/profil/cubit/data_user_cubit.dart';
import 'package:carraze/features/profil/cubit/data_user_state.dart';
import 'package:carraze/features/profil/presentation/widgets/buildInfoRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';

class UserProfileInfoPage extends StatelessWidget {
  const UserProfileInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch user info when the page loads
    final cubit = context.read<DataUserCubit>();
    cubit.getUserInfo();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          txt: 'Profile Info',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (GoRouter.of(context).canPop()) {
              context.pop();
            } else {
              context.go(RouteNames.profile);
            }
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/car1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<DataUserCubit, DataUserState>(
            builder: (context, state) {
              if (state is DataUserLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DataUserLoaded) {
                final user = state.user;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[800],
                        backgroundImage: user.imageUrl.isNotEmpty
                            ? NetworkImage(user.imageUrl)
                            : null,
                        child: user.imageUrl.isEmpty
                            ? const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 60,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: CustomText(
                        txt: 'Personal Information',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 15),
                    buildInfoRow('Full Name', user.name),
                    buildInfoRow('Email', user.email),
                    buildInfoRow('Phone Number', user.phone),
                    buildInfoRow('Additional Info', user.additionalInfo),
                    const SizedBox(height: 30),
                    CustomButton(
                      backgroundColor: const Color(0xFF2E4A62),
                      content: CustomText(
                        txt: 'Edit Profile',
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      onPressed: () {
                        context.go('/edit-profile', extra: user);
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomButton(
                      backgroundColor: const Color(0xFFF44336),
                      content: CustomText(
                        txt: 'Delete Account',
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      onPressed: () {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.confirm,
                          title: 'Delete Account',
                          text:
                              'Are you sure you want to delete your account? This action cannot be undone.',
                          confirmBtnText: 'Delete',
                          cancelBtnText: 'Cancel',
                          onConfirmBtnTap: () {
                            cubit.deleteUser(user.uid);
                            context.go(RouteNames.login);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () => cubit.getUserInfo(),
                      child: Text('Refresh'),
                    ),
                  ],
                );
              } else if (state is DataUserError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error: ${state.message}',
                        style: TextStyle(color: Colors.white),
                      ),
                      ElevatedButton(
                        onPressed: () => cubit.getUserInfo(),
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text(
                    'No user data available',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
