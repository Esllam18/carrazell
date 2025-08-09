// import 'dart:ui';

// import 'package:carraze/core/models/fiv_car.dart';
// import 'package:carraze/core/router/route_names.dart';
// import 'package:carraze/core/widgets/custom_button.dart';
// import 'package:carraze/core/widgets/custom_text.dart';
// import 'package:carraze/features/fiv%20feature/cubit/favorites_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// Widget buildFavoriteItem(BuildContext context, FavoriteCar car) {
//   return Container(
//     margin: const EdgeInsets.only(bottom: 15),
//     decoration: BoxDecoration(
//       color: const Color(0xFF1E1E1E).withOpacity(0.9),
//       borderRadius: BorderRadius.circular(12),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black26,
//           blurRadius: 10,
//           offset: const Offset(0, 5),
//         ),
//       ],
//     ),
//     child: ListTile(
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       leading: Container(
//         width: 80,
//         height: 80,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           image: DecorationImage(
//             image: AssetImage(
//               car.imageUrl,
//             ), // Use a default image or fetch dynamically
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//       title: CustomText(
//         txt: car.name,
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//         color: Colors.white,
//       ),
//       subtitle: CustomText(
//         txt: '${car.model} (${car.year})',
//         fontSize: 14,
//         color: Colors.white70,
//       ),
//       trailing: SizedBox(
//         width: 80,
//         child: CustomButton(
//           backgroundColor: const Color(0xFFF44336),
//           content: CustomText(
//             txt: 'Remove',
//             fontSize: 14,
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//           onPressed: () => context.read<FavoritesCubit>().removeFavorite(car),
//         ),
//       ),
//       onTap: () {
//         // Navigate to car details if needed
//         GoRouter.of(context).push(
//           RouteNames.carDetail,
//           extra: {
//             'name': car.name,
//             'model': car.model,
//             'year': car.year.toString(),
//             // Add other fields as needed
//           },
//         );
//       },
//     ),
//   );
// }
