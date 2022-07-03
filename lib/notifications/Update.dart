import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateStatus{



  
  addpaymentDataToDb(
      {
      required bool status,
      required final DocumentSnapshot document,
     }) async {
    Map<String, dynamic> body = {
      
      "Seen": true,
     
    };
    try {
      await FirebaseFirestore.instance
          .collection('Notifications')
          .doc('document')
          .set(body);
    } catch (e) {
      print('error');
    }
  }
}