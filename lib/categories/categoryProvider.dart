import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class categoryprovider with ChangeNotifier{

   String?  Selectedcategory;

  getCategoryDetails( details){
    this.Selectedcategory=details;
    notifyListeners();
  }

  ClearSelectedCategory(){
    this.Selectedcategory = null;
    notifyListeners();

  }
}