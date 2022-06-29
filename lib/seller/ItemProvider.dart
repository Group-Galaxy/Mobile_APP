import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ItemProvider with ChangeNotifier{

  late DocumentSnapshot ItemtData;

  getItemDetails(details){
    this.ItemtData=details;
    notifyListeners();
  }
}