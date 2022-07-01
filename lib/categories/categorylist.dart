import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mypart/buyer/productbycategory.dart';
import 'package:mypart/buyer/vehicle_parts_home.dart';
import 'package:mypart/categories/categoryProvider.dart';
import 'package:mypart/firebaseservice.dart';

import 'package:provider/provider.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();
    var _provider = Provider.of<categoryprovider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => VehiclePartsHome()));
          },
        ),
        title: Text('categories'),
      ),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: _service.categories.orderBy('Name', descending: false).get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var doc = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          onTap: () => {
                            _provider.getCategoryDetails(doc['Name']),
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProductByCategory())),
                          },
                          leading: Image.network(
                            doc['Imageurl'],
                            width: 40,
                            height: 50,
                          ),
                          title: Text(
                            doc['Name'],
                            style: TextStyle(fontSize: 15),
                          ),
                          trailing:
                              Icon(Icons.arrow_forward_ios_rounded, size: 14),
                        ),
                      );
                    }));
          },
        ),
      ),
    );
  }
}
