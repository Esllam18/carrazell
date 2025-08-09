import 'package:carraze/core/models/car_model.dart';
import 'package:carraze/features/home/domin/get_cars_remote_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetCarsRemoteDataSourceImpl implements GetCarsRemoteDataSource {
  final fireStore = FirebaseFirestore.instance;

  @override
  Future<List<Car>> getCarList() async {
    final snapshot = await fireStore.collection('cars').get();
    final cars = snapshot.docs.map((doc) => Car.fromJson(doc.data())).toList();

    return cars;
  }
}
