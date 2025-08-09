import 'package:carraze/core/router/route_names.dart';
import 'package:carraze/core/widgets/custom_snackbar.dart';
import 'package:carraze/core/widgets/custom_text.dart';
import 'package:carraze/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  bool _notificationsEnabled = true;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: CustomText(
          txt: 'Account Settings',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              CustomText(
                txt: 'Preferences',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: CustomText(
                        txt: 'Enable Notifications',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      value: _notificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                        CustomSnackBar.show(
                          context,
                          message:
                              'Notifications ${value ? 'enabled' : 'disabled'}',
                          type: SnackBarType.success,
                        );
                      },
                      activeColor: const Color(0xFF2E4A62),
                      inactiveTrackColor: Colors.grey[700],
                    ),
                    const Divider(color: Colors.white24, height: 1),
                    ListTile(
                      title: CustomText(
                        txt: 'Change Password',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.white70,
                      ),
                      onTap: () {
                        GoRouter.of(context).push(RouteNames.changePassword);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              CustomText(
                txt: 'Language',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  value: _language,
                  dropdownColor: const Color(0xFF1E1E1E),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white70,
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  underline: const SizedBox(),
                  items: <String>['English', 'Spanish', 'French', 'German'].map(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: CustomText(txt: value, fontSize: 16),
                      );
                    },
                  ).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _language = newValue;
                      });
                      CustomSnackBar.show(
                        context,
                        message: 'Language changed to $newValue',
                        type: SnackBarType.success,
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 30),
              CustomButton(
                backgroundColor: const Color(0xFF2E4A62),
                content: CustomText(
                  txt: 'Save Settings',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                onPressed: () {
                  CustomSnackBar.show(
                    context,
                    message: 'Settings saved successfully!',
                    type: SnackBarType.success,
                  );
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
