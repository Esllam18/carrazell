import 'package:carraze/core/models/fiv_car.dart';
import 'package:carraze/core/router/route_names.dart';
import 'package:carraze/core/widgets/custom_text.dart';
import 'package:carraze/core/widgets/custom_button.dart';
import 'package:carraze/features/fiv%20feature/cubit/favorites_cubit.dart';
import 'package:carraze/features/fiv%20feature/cubit/favorites_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: CustomText(
            txt: 'Favorites',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/car1.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, state) {
                if (state is FavoritesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FavoritesUpdated) {
                  final favoriteCars = state.favorites;
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (favoriteCars.isEmpty)
                                Center(
                                  child: CustomText(
                                    txt: 'No favorites yet!',
                                    fontSize: 18,
                                    color: Colors.white70,
                                  ),
                                ),
                              if (favoriteCars.isNotEmpty)
                                ...favoriteCars
                                    .map(
                                      (car) => _buildFavoriteItem(context, car),
                                    )
                                    .toList(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is FavoritesError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          txt: state.message,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          backgroundColor: const Color(0xFF2E4A62),
                          content: CustomText(
                            txt: 'Retry',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          onPressed: () =>
                              context.read<FavoritesCubit>().loadFavorites(),
                        ),
                      ],
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteItem(BuildContext context, FavoriteCar car) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
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
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              car.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error, color: Colors.red),
            ),
          ),
        ),
        title: CustomText(
          txt: car.name,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        subtitle: CustomText(
          txt: '${car.model} (${car.year})',
          fontSize: 14,
          color: Colors.white70,
        ),
        trailing: SizedBox(
          width: 80,
          child: CustomButton(
            backgroundColor: const Color(0xFFF44336),
            content: CustomText(
              txt: 'Remove',
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            onPressed: () =>
                context.read<FavoritesCubit>().removeFavoriteById(car.id),
          ),
        ),
        onTap: () {
          GoRouter.of(context).push(RouteNames.carDetail, extra: car);
        },
      ),
    );
  }
}
