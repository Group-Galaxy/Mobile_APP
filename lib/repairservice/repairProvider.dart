import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class RepairProvider with ChangeNotifier{

  late DocumentSnapshot serviceProviderData;

  getProductDetails(details){
    this.serviceProviderData=details;
    notifyListeners();
  }
}