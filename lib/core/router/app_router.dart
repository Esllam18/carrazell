import 'package:carraze/core/models/car_model.dart';
import 'package:carraze/core/models/user_model.dart';
import 'package:carraze/core/router/route_names.dart';
import 'package:carraze/features/add_car/presentation/pages/add_car_page.dart';
import 'package:carraze/features/auth/presentation/pages/login.dart';
import 'package:carraze/features/auth/presentation/pages/sign_up.dart';
import 'package:carraze/features/auth/presentation/widgets/reset_password.dart';
import 'package:carraze/features/car_detilse/presentation/pages/car_detilse_view.dart';
import 'package:carraze/features/fiv%20feature/persntation/favorites_page.dart';
import 'package:carraze/features/profil/presentation/pages/account_settings_page.dart';
import 'package:carraze/features/profil/presentation/pages/edit_profile_page.dart';
import 'package:carraze/features/profil/presentation/pages/payment_methods_page.dart';
import 'package:carraze/features/profil/presentation/pages/profile_view.dart.dart';
import 'package:carraze/features/profil/presentation/pages/user_profile_info_page.dart';
import 'package:carraze/features/profil/presentation/widgets/change_password.dart';
import 'package:carraze/features/saerch/presentation/pages/search_page.dart';
import 'package:carraze/root.dart';
import 'package:carraze/features/splach/splach_view.dart';
import 'package:carraze/features/splach/wlcome_view.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: RouteNames.splash, builder: (context, state) => SplashView()),
    GoRoute(
      path: RouteNames.welcome,
      builder: (context, state) => WelcomeView(),
    ),
    GoRoute(path: RouteNames.login, builder: (context, state) => Login()),
    GoRoute(path: RouteNames.signUp, builder: (context, state) => SignUp()),
    GoRoute(path: RouteNames.home, builder: (context, state) => HomePage()),
    GoRoute(
      path: RouteNames.profile,
      builder: (context, state) => ProfileView(),
    ),
    GoRoute(
      path: RouteNames.carDetail,
      builder: (context, state) {
        final Car car = state.extra as Car;
        return CarDetailsPage(
          carName: car.carName,
          manufacturer: car.manufacturer,
          model: car.model,
          year: car.year,
          fuelType: car.fuelType,
          mileage: car.mileage,
          price: car.price,
          imagePath: car.imagePath,
        );
      },
    ),
    GoRoute(
      path: RouteNames.userIfon,
      builder: (context, state) => UserProfileInfoPage(),
    ),
    GoRoute(
      path: RouteNames.editProfile,
      builder: (context, state) {
        final user = state.extra as UserModel?;
        return EditProfilePage(user: user);
      },
    ),
    GoRoute(
      path: RouteNames.accountSettings,
      builder: (context, state) => AccountSettingsPage(),
    ),
    GoRoute(
      path: RouteNames.changePassword,
      builder: (context, state) => ChangePasswordPage(),
    ),
    GoRoute(
      path: RouteNames.paymentMethods,
      builder: (context, state) => PaymentMethodsPage(),
    ),
    GoRoute(
      path: RouteNames.favorites,
      builder: (context, state) => FavoritesPage(),
    ),
    GoRoute(path: RouteNames.search, builder: (context, state) => SearchPage()),
    GoRoute(path: RouteNames.addCar, builder: (context, state) => AddCarPage()),
    GoRoute(
      path: RouteNames.reastpassword,
      builder: (context, state) => ResetPassword(),
    ),
  ],
);
