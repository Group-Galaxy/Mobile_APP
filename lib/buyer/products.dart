import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:mypart/buyer/productProvider.dart';
import 'package:mypart/buyer/productmoreinfo.dart';
import 'package:mypart/categories/categoryProvider.dart';
import 'package:mypart/firebaseservice.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  final bool Proscreen;
  const ProductList(this.Proscreen);

  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();
    var catProvider = Provider.of<categoryprovider>(context);

    final PriceFormat = NumberFormat('##,##,##0');

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: FutureBuilder<QuerySnapshot>(
          future: service.VehicleItems.orderBy('PostedDate')
              .where('Item Category', isEqualTo: catProvider.Selectedcategory)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.only(left: 140, right: 140),
                child: LinearProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                  backgroundColor: Colors.purple.shade100,
                ),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No products added to this selected category"),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Proscreen == false)
                  Container(
                    child: const Text(
                      'Recomoned For You',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                GridView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 210,
                      childAspectRatio: 2 / 2.1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: snapshot.data!.size,
                    itemBuilder: (BuildContext context, int i) {
                      var data = snapshot.data!.docs[i];
                      var price = int.parse(data['Item Price']);

                      String FormatedPrice = 'Rs. ${PriceFormat.format(price)}';

                      var provider = Provider.of<ProductProvider>(context);

                      return InkWell(
                        onTap: () {
                          provider.getProductDetails(data);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => productDetails()));
                        },
                        child: Container(
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8, top: 8),
                                    child: SizedBox(
                                      height: 80,
                                      child: Center(
                                        child: Image.network(data['Imageurl']),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8, top: 8),
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              data['Item Name'],
                                              style:
                                                  const TextStyle(fontSize: 12),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              FormatedPrice,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              'Warrenty : ' +
                                                  data['Warenty Period'],
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                right: 0.0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: LikeButton(
                                    circleColor: const CircleColor(
                                        start: Color(0xff00ddff),
                                        end: Color(0xff0099cc)),
                                    bubblesColor: const BubblesColor(
                                      dotPrimaryColor: Color(0xff33b5e5),
                                      dotSecondaryColor: Color(0xff0099cc),
                                    ),
                                    likeBuilder: (bool isLiked) {
                                      return Icon(
                                        Icons.favorite,
                                        color: isLiked
                                            ? Colors.purple
                                            : Colors.grey,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.purple.withOpacity(.8),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      );
                    }),
              ],
            );
          },
        ),
      ),
    );
  }
}
