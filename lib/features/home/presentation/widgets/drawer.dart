import 'package:carraze/core/router/route_names.dart';
import 'package:carraze/core/widgets/custom_text.dart';
import 'package:carraze/features/profil/cubit/data_user_cubit.dart';
import 'package:carraze/features/profil/cubit/data_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  final Function(String) onMenuItemTap;

  const CustomDrawer({super.key, required this.onMenuItemTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF1C2526)),
            child: BlocBuilder<DataUserCubit, DataUserState>(
              builder: (context, state) {
                if (state is DataUserLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DataUserLoaded) {
                  final user = state.user;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[800],
                        backgroundImage: user.imageUrl.isNotEmpty
                            ? NetworkImage(user.imageUrl)
                            : null,
                        child: user.imageUrl.isEmpty
                            ? const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 40,
                              )
                            : null,
                      ),
                      const SizedBox(height: 10),
                      CustomText(
                        txt: user.name,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      CustomText(
                        txt: user.email,
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ],
                  );
                } else if (state is DataUserError) {
                  return Center(
                    child: CustomText(
                      txt: 'Error: ${state.message}',
                      color: Colors.white,
                    ),
                  );
                } else {
                  return const Center(
                    child: CustomText(
                      txt: 'No user data available',
                      color: Colors.white,
                    ),
                  );
                }
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Color(0xFF2E4A62)),
            title: CustomText(txt: 'Home', color: Colors.white),
            onTap: () => onMenuItemTap('/home'),
          ),
          ListTile(
            leading: const Icon(Icons.favorite, color: Color(0xFF2E4A62)),
            title: CustomText(txt: 'Favorites', color: Colors.white),
            onTap: () {
              GoRouter.of(context).push(RouteNames.favorites);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Color(0xFF2E4A62)),
            title: CustomText(txt: 'Profile', color: Colors.white),
            onTap: () {
              GoRouter.of(context).push(RouteNames.profile);
            },
          ),
          ListTile(
            leading: const Icon(Icons.search, color: Color(0xFF2E4A62)),
            title: CustomText(txt: 'Search', color: Colors.white),
            onTap: () {
              GoRouter.of(context).push(RouteNames.search);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Color(0xFF2E4A62)),
            title: CustomText(txt: 'Setings', color: Colors.white),
            onTap: () {
              GoRouter.of(context).push(RouteNames.accountSettings);
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment, color: Color(0xFF2E4A62)),
            title: CustomText(txt: 'Payment Methods', color: Colors.white),
            onTap: () {
              GoRouter.of(context).push(RouteNames.paymentMethods);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit, color: Color(0xFF2E4A62)),
            title: CustomText(txt: 'Edit Profile', color: Colors.white),
            onTap: () {
              GoRouter.of(context).push(RouteNames.editProfile);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add, color: Color(0xFF2E4A62)),
            title: CustomText(txt: 'Add Car', color: Colors.white),
            onTap: () {
              GoRouter.of(context).push(RouteNames.addCar);
            },
          ),
          const Divider(color: Colors.grey),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Ionicons.logo_whatsapp,
                    color: Colors.green,
                    size: 30,
                  ),
                  onPressed: () {
                    launchUrl(Uri.parse("https://wa.me/201155374945"));
                  },
                ),
                const SizedBox(width: 15),
                IconButton(
                  icon: const Icon(
                    Ionicons.logo_facebook,
                    color: Colors.blue,
                    size: 30,
                  ),
                  onPressed: () {
                    launchUrl(Uri.parse("https://facebook.com/username"));
                  },
                ),
                const SizedBox(width: 15),
                IconButton(
                  icon: const Icon(
                    Ionicons.logo_instagram,
                    color: Colors.purple,
                    size: 30,
                  ),
                  onPressed: () {
                    launchUrl(Uri.parse("https://instagram.com/username"));
                  },
                ),
                const SizedBox(width: 15),
                IconButton(
                  icon: const Icon(
                    Ionicons.logo_twitter,
                    color: Colors.lightBlue,
                    size: 30,
                  ),
                  onPressed: () {
                    launchUrl(Uri.parse("https://twitter.com/username"));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
