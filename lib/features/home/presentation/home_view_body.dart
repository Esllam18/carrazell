import 'package:carraze/core/router/route_names.dart';
import 'package:carraze/core/widgets/custom_text.dart';
import 'package:carraze/features/home/cubit/get_cars_cubit.dart';
import 'package:carraze/features/home/presentation/widgets/buildCarCard.dart';
import 'package:carraze/features/home/presentation/widgets/buildCategoryChip.dart';
import 'package:carraze/features/home/presentation/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeBodyView extends StatefulWidget {
  const HomeBodyView({super.key});

  @override
  State<HomeBodyView> createState() => _HomeBodyViewState();
}

class _HomeBodyViewState extends State<HomeBodyView> {
  final List<String> categories = [
    "All",
    'Aston Martin (UK)',
    'Audi (Germany)',
    'Bentley (UK)',
    'BMW (Germany)',
    'Chery (China)',
    'Chevrolet (USA)',
    'Citroen (France)',
    'Ford (USA)',
    'Genesis (South Korea)',
    'General Motors (USA)',
    'Honda (Japan)',
    'Hyundai (South Korea)',
    'Jaguar (UK)',
    'Jeep (USA)',
    'Land Rover (UK)',
    'Lotus (UK)',
    'Lucid (USA)',
    'Maserati (Italy)',
    'Maybach (Germany)',
    'McLaren (UK)',
    'Mercedes-Benz (Germany)',
    'Nissan (Japan)',
    'Peugeot (France)',
    'Renault (France)',
    'Rolls-Royce (UK)',
    'Stellantis (Multinational)',
    'Suzuki (Japan)',
    'Toyota (Japan)',
    'Venturi (France)',
    'Volkswagen (Germany)',
  ];

  String selectedCategory = "All";
  double _opacity = 0.0;
  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetCarsCubit>(context).fetchCars();
  }

  void onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
    BlocProvider.of<GetCarsCubit>(context).filterCarsByCategory(category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        onMenuItemTap: (route) {
          Navigator.pop(context);
          Navigator.pushNamed(context, route);
        },
      ),
      body: StreamBuilder<GetCarsState>(
        stream: BlocProvider.of<GetCarsCubit>(context).stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  TextButton(
                    onPressed: () =>
                        BlocProvider.of<GetCarsCubit>(context).fetchCars(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            final state = snapshot.data!;
            if (state is GetCarsSuccess) {
              final cars = state.cars;
              if (!_dataLoaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _opacity = 1.0;
                    _dataLoaded = true;
                  });
                });
              }
              return AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(milliseconds: 500),
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/car1.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          floating: true,
                          snap: true,
                          pinned: false,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          centerTitle: true,
                          title: CustomText(
                            txt: 'Cars',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          leading: IconButton(
                            icon: const Icon(Icons.menu, color: Colors.white),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 16)),
                        SliverToBoxAdapter(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: categories
                                  .map(
                                    (category) => buildCategoryChip(
                                      category: category,
                                      onSelected: (selectedCategory) {
                                        onCategorySelected(category);
                                      },
                                      selectedCategory: selectedCategory,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 16)),
                        SliverGrid(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            return CarCard(
                              price: cars[index].price,
                              carName: cars[index].carName,
                              onTap: () {
                                try {
                                  GoRouter.of(context).push(
                                    RouteNames.carDetail,
                                    extra: cars[index],
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Navigation error: $e'),
                                    ),
                                  );
                                }
                              },
                              imagePath: cars[index].imagePath,
                            );
                          }, childCount: cars.length),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.75,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (state is GetCarsFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    TextButton(
                      onPressed: () =>
                          BlocProvider.of<GetCarsCubit>(context).fetchCars(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
