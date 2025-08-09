import 'package:carraze/core/functions/open_whatsApp_with_phone_number.dart';
import 'package:carraze/core/models/fiv_car.dart';
import 'package:carraze/core/widgets/custom_snackbar.dart';
import 'package:carraze/core/widgets/custom_text.dart';
import 'package:carraze/core/widgets/custom_button.dart';
import 'package:carraze/features/car_detilse/presentation/pages/widgets/buildSpecRow.dart';
import 'package:carraze/features/fiv%20feature/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class CarDetailsPage extends StatelessWidget {
  final String carName;
  final String manufacturer;
  final String model;
  final String year;
  final String fuelType;
  final String mileage;
  final String price;
  final String imagePath;

  const CarDetailsPage({
    super.key,
    required this.carName,
    required this.manufacturer,
    required this.model,
    required this.year,
    required this.fuelType,
    required this.mileage,
    required this.price,
    required this.imagePath,
  });

  String _buildWhatsAppMessage() {
    return '''
Check out this car!
- Name: $carName
- Manufacturer: $manufacturer
- Model: $model
- Year: $year
- Fuel Type: $fuelType
- Mileage: $mileage km
- Price: $price
- Image: $imagePath
Interested? Contact us!
''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          txt: 'Car Details',
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
              Center(
                child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildSpecRow('Manufacturer', manufacturer),
              buildSpecRow('Model', model),
              buildSpecRow('Year', year),
              buildSpecRow('Fuel Type', fuelType),
              buildSpecRow('Mileage', '$mileage km'),
              buildSpecRow('Price', '\$$price'),
              const SizedBox(height: 30),
              CustomButton(
                backgroundColor: const Color(0xFF2E4A62),
                content: CustomText(
                  txt: 'Add to Favorites',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                onPressed: () {
                  final favoriteCar = FavoriteCar(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: carName,
                    model: model,
                    year: int.parse(year),
                    imageUrl: imagePath,
                  );
                  context.read<FavoritesCubit>().addFavorite(favoriteCar);
                  ;
                  CustomSnackBar.show(
                    context,
                    message: '$carName added to favorites!',
                    type: SnackBarType.success,
                  );
                },
              ),
              const Gap(20),
              CustomButton(
                backgroundColor: const Color(0xFF25D366),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Ionicons.logo_whatsapp,
                      color: Colors.white,
                      size: 24,
                    ),
                    const Gap(10),
                    CustomText(
                      txt: 'Share on WhatsApp',
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                onPressed: () async {
                  const String defaultPhoneNumber = '01155374945';
                  final message = _buildWhatsAppMessage();
                  final success = await openWhatsApp(
                    defaultPhoneNumber,
                    message: message,
                  );
                  if (!success) {
                    CustomSnackBar.show(
                      context,
                      message: 'Failed to open WhatsApp. Please try again.',
                      type: SnackBarType.error,
                    );
                  }
                },
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
