import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mypart/buyer/productbycategory.dart';
import 'package:mypart/categories/categoryProvider.dart';
import 'package:mypart/categories/categorylist.dart';
import 'package:mypart/firebaseservice.dart';
import 'package:provider/provider.dart';
class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseService _service=FirebaseService();


    return Container(
      child:FutureBuilder<QuerySnapshot>(
      future:_service.categories.orderBy('Name',descending:false).get() ,
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
          color: Color.fromARGB(255, 237, 214, 236),
          height: 170,
         
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(child: Text("categories"
                  ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),)
                  ),
                  TextButton
                  (onPressed: (){
                    Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => CategoryList()));
                  }, 
                  child: Row(
                    children: [
                      Text("see all"),
                      Icon(Icons.arrow_forward_ios,size: 12,)
                      
                    ],
                  ),
                    ),
                ],),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder:(BuildContext context,int index){
                      var doc =snapshot.data!.docs[index];
                         var _provider=Provider.of<categoryprovider>(context);
                  return  InkWell(
                      onTap: () {
                        _provider.getCategoryDetails(doc['Name']);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProductByCategory()));
                      },
                      child: Column(
                        children: [
                          
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                           width: 50,
                          height: 50,
                          child: Image.network(doc['Imageurl'],width: 40,height: 60,)
                          ),
                      ),
                      Text(doc['Name'],style: TextStyle(fontSize: 10,)),
                        ],
                      ),
                    );
                  
                }
                
                )
                ),
            ]),
        );
      },
    ),
    );
  }
}