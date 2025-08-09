import 'dart:io';

import 'package:carraze/core/models/car_model.dart';
import 'package:carraze/features/add_car/data/addCar_remote_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddCarRemoteDataSourceImpl implements AddCarRemoteDataSource {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  AddCarRemoteDataSourceImpl(

  );

  @override
  Future<void> addCar({
    required String carName,
    required String manufacturer,
    required String model,
    required String year,
    required String fuelType,
    required String mileage,
    required String price,
    required File imageFile,
  }) async {
    // 1. رفع الصورة
    final imageRef = storage.ref().child('cars/${DateTime.now().millisecondsSinceEpoch}');
    // ignore: unused_local_variable
    final uploadTask = await imageRef.putFile(imageFile);
    final imageUrl = await imageRef.getDownloadURL();

    // 2. إنشاء object للسيارة
    final car = Car(
      carName: carName,
      manufacturer: manufacturer,
      model: model,
      year: year,
      fuelType: fuelType,
      mileage: mileage,
      price: price,
      imagePath: imageUrl,
    );

    
    await firestore.collection('cars').add(car.toJson());
  }
}
