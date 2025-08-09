import 'dart:io';

import 'package:carraze/core/router/route_names.dart';
import 'package:carraze/core/widgets/custom_snackbar.dart';
import 'package:carraze/core/widgets/custom_text.dart';
import 'package:carraze/features/add_car/cubit/add_car_cubit.dart';
import 'package:carraze/features/add_car/cubit/add_car_state.dart';
import 'package:carraze/features/add_car/presentation/widgets/add_car_view_body.dart';
import 'package:carraze/features/add_car/presentation/widgets/add_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({super.key});

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _modelController = TextEditingController();
  final _priceController = TextEditingController();
  final _infoController = TextEditingController();
  final _manufacturerController = TextEditingController();
  final _fuelTypeController = TextEditingController();
  final _mileageController = TextEditingController();
  final _yearController = TextEditingController();

  File? _image;

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        CustomSnackBar.show(
          context,
          message: 'Image selected successfully',
          type: SnackBarType.success,
        );
      } else {
        CustomSnackBar.show(
          context,
          message: 'No image selected',
          type: SnackBarType.info,
        );
      }
    } catch (e) {
      CustomSnackBar.show(
        context,
        message: 'Error picking image: $e',
        type: SnackBarType.error,
      );
      print('Image picking error: $e');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _modelController.dispose();
    _priceController.dispose();
    _infoController.dispose();
    _manufacturerController.dispose();
    _fuelTypeController.dispose();
    _mileageController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: CustomText(
          txt: 'Add New Car',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/car1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: CustomAddImageCard(
                  onPickImage: _pickImage,
                  image: _image,
                ),
              ),
              BlocListener<AddCar, AddCarState>(
                listener: (context, state) {
                  if (state is AddCarSuccess) {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      title: "Success",
                      text: "Car Added Successfully",
                      confirmBtnText: "OK",
                      onConfirmBtnTap: () {
                        GoRouter.of(context).push(RouteNames.home);
                      },
                    );
                  }
                  if (state is AddCarFailure) {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      text: state.errorMessage,
                    );
                  }
                  if (state is AddCarLoading) {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.loading,
                      text: "Loading...",
                      barrierDismissible: false,
                    );
                  }
                },
                child: AddCarViewBody(
                  formKey: _formKey,
                  nameController: _nameController,
                  modelController: _modelController,
                  priceController: _priceController,
                  infoController: _infoController,
                  manufacturerController: _manufacturerController,
                  fuelTypeController: _fuelTypeController,
                  mileageController: _mileageController,
                  yearController: _yearController,
                  onAddCarPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AddCar>().addCar(
                        carName: _nameController.text,
                        model: _modelController.text,
                        price: _priceController.text,

                        manufacturer: _manufacturerController.text,
                        fuelType: _fuelTypeController.text,
                        mileage: _mileageController.text,
                        year: _yearController.text,
                        imageFile: _image!,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
