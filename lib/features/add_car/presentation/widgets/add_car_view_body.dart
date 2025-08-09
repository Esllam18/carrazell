import 'package:carraze/core/widgets/custom_button.dart';
import 'package:carraze/core/widgets/custom_text.dart';
import 'package:carraze/core/widgets/custom_text_field.dart';

import 'package:flutter/material.dart';

class AddCarViewBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController modelController;
  final TextEditingController priceController;
  final TextEditingController infoController;
  final TextEditingController manufacturerController;
  final TextEditingController fuelTypeController;
  final TextEditingController mileageController;
  final TextEditingController yearController;
  final VoidCallback onAddCarPressed;

  const AddCarViewBody({
    Key? key,
    required this.formKey,
    required this.nameController,
    required this.modelController,
    required this.priceController,
    required this.infoController,
    required this.manufacturerController,
    required this.fuelTypeController,
    required this.mileageController,
    required this.yearController,
    required this.onAddCarPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            CustomText(
              txt: 'Basic Information',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              controller: nameController,
              hintText: 'Car Name',
              validator: (value) {
                if (value == null || value.isEmpty) return 'Enter car name';
                if (value.length < 2)
                  return 'Name must be at least 2 characters';
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: modelController,
              hintText: 'Model',
              validator: (value) {
                if (value == null || value.isEmpty) return 'Enter model';
                if (value.length < 2)
                  return 'Model must be at least 2 characters';
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: manufacturerController,
              hintText: 'Manufacturer',
              validator: (value) {
                if (value == null || value.isEmpty) return 'Enter manufacturer';
                if (value.length < 2)
                  return 'Manufacturer must be at least 2 characters';
                return null;
              },
            ),
            const SizedBox(height: 30),
            CustomText(
              txt: 'Specifications',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              controller: yearController,
              hintText: 'Year',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Enter year';
                if (int.tryParse(value) == null) return 'Enter a valid number';
                final year = int.parse(value);
                if (year < 1900 || year > 2025)
                  return 'Year must be between 1900 and 2025';
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: fuelTypeController,
              hintText: 'Fuel Type',
              validator: (value) {
                if (value == null || value.isEmpty) return 'Enter fuel type';
                if (value.length < 2)
                  return 'Fuel type must be at least 2 characters';
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: mileageController,
              hintText: 'Mileage (km)',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Enter mileage';
                if (int.tryParse(value) == null) return 'Enter a valid number';
                if (int.parse(value) < 0) return 'Mileage cannot be negative';
                return null;
              },
            ),
            const SizedBox(height: 30),
            CustomText(
              txt: 'Pricing & Info',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              controller: priceController,
              hintText: r'Price ($)',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Enter price';
                if (double.tryParse(value) == null)
                  return 'Enter a valid number';
                if (double.parse(value) < 0) return 'Price cannot be negative';
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: infoController,
              hintText: 'Additional Info',
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Enter additional info';
                if (value.length < 10)
                  return 'Info must be at least 10 characters';
                return null;
              },
            ),
            const SizedBox(height: 40),
            CustomButton(
              backgroundColor: const Color(0xFF2E4A62),
              content: CustomText(
                txt: 'Add Car',
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              onPressed: onAddCarPressed,
            ),
          ],
        ),
      ),
    );
  }
}
