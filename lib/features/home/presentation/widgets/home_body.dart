// import 'package:carraze/core/widgets/custom_text_field.dart';
// import 'package:carraze/features/home/presentation/widgets/buildCarCard.dart';
// import 'package:carraze/features/home/presentation/widgets/buildCategoryChip.dart';
// import 'package:flutter/material.dart';

// class HomeBody extends StatelessWidget {
//   final TextEditingController searchController;
//   final List<String> categories;
//   final List<String> cars;
//   final VoidCallback clearSearch;
//   final Function(String) onCategoryTap;
//   final Function(String) onCarTap;
//   final String imagePath;
//   final String carName;

//   const HomeBody({
//     super.key,
//     required this.searchController,
//     required this.categories,
//     required this.cars,
//     required this.clearSearch,
//     required this.onCategoryTap,
//     required this.onCarTap,
//     required this.imagePath,
//     required this.carName,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CustomTextField(
//             controller: searchController,
//             hintText: 'Search cars...',
//             suffixIcon: searchController.text.isNotEmpty
//                 ? IconButton(
//                     icon: const Icon(Icons.clear, color: Colors.white),
//                     onPressed: clearSearch,
//                   )
//                 : null,
//             fillColor: const Color(0xFF1E1E1E),
//           ),
//           const SizedBox(height: 16),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: categories
//                   .map((category) => buildCategoryChip(category, onCategoryTap))
//                   .toList(),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Expanded(
//             child: GridView.builder(
//               padding: const EdgeInsets.only(
//                 bottom: 16.0,
//               ), // Avoid bottom overlap
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 0.75, // Adjusted for image and text
//               ),
//               itemCount: cars.length,
//               itemBuilder: (context, index) {
//                 return CarCard(
//                   carName: carName,

//                   onTap: () => onCarTap(cars[index]),
//                   imagePath: imagePath,
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
