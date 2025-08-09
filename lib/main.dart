import 'package:carraze/features/add_car/cubit/add_car_cubit.dart';
import 'package:carraze/features/add_car/data/addCar_remote_data_source_impl.dart';
import 'package:carraze/features/add_car/data/addCar_repository_impl.dart';
import 'package:carraze/features/auth/data/auth_remote_data_source_impl.dart';
import 'package:carraze/features/auth/data/auth_repository_impl.dart';
import 'package:carraze/features/auth/logic/cubit/auth_cubit.dart';
import 'package:carraze/features/fiv%20feature/cubit/favorites_cubit.dart';
import 'package:carraze/features/home/cubit/get_cars_cubit.dart';
import 'package:carraze/features/home/data/get_cars_repository_impl.dart';
import 'package:carraze/features/home/domin/get_cars_remote_data_source_impl.dart';
import 'package:carraze/features/profil/cubit/data_user_cubit.dart';
import 'package:carraze/features/profil/data/data_user_repository_impl.dart';
import 'package:carraze/features/profil/domin/data_user_remote_data_source_imp.dart';
import 'package:carraze/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:carraze/core/router/app_router.dart';
import 'package:carraze/core/utils/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Carraze());
}

class Carraze extends StatelessWidget {
  const Carraze({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) =>
              AuthCubit(AuthRepositoryImpl(AuthRemoteDataSourceImpl())),
        ),

        BlocProvider<AddCar>(
          create: (context) =>
              AddCar(AddCarRepositoryImpl(AddCarRemoteDataSourceImpl())),
        ),
        BlocProvider<GetCarsCubit>(
          create: (context) => GetCarsCubit(
            GetCarsRepositoryImpl(GetCarsRemoteDataSourceImpl()),
          ),
        ),
        BlocProvider<DataUserCubit>(
          create: (context) => DataUserCubit(
            DataUserRepositoryImpl(DataUserRemoteDataSourceImpl()),
          ),
        ),
        BlocProvider<FavoritesCubit>(create: (context) => FavoritesCubit()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Carraze',
        theme: AppTheme.darkTheme,
        routerConfig: router,
      ),
    );
  }
}
