import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService{
  final CollectionReference categories = FirebaseFirestore.instance.collection('categories');
   final CollectionReference VehicleItems = FirebaseFirestore.instance.collection('Vehicle Parts');
   final CollectionReference users = FirebaseFirestore.instance.collection('users');
   final CollectionReference VehiclePartsProviders = FirebaseFirestore.instance.collection('vehicl parts providers');
   
}