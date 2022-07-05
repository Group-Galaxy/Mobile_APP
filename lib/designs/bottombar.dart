import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypart/orders/order_userside/userordermain.dart';
import 'package:mypart/usermangment/loginhome.dart';

import '../chat/chat_home.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.transparent,
        elevation: 9.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
            height: 50.0,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0)),
                color: Colors.purple),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.home),
                            color: Colors.white,
                            tooltip: ' Home',
                            onPressed: () {
                               Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const DriverHome()));
                            },
                          ),
                          IconButton(
                            icon: const Icon(CupertinoIcons.square_list),
                            tooltip: 'Orders',
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const Myorders()));
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.chat),
                            tooltip: 'chat',
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const ChatHome(
                                            sender: "VehicleOwner",
                                          )));
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.favorite),
                            tooltip: 'wish list',
                            color: Colors.white,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.notifications),
                            tooltip: 'Notifications',
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ],
                      )),
                  /*Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width / 2 - 40.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.favorite),
                            tooltip: 'wishlist',
                            color: Colors.purple,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.notifications),
                            tooltip: 'notifications',
                            color: Colors.purple,
                            onPressed: () {},
                          ),
                        ],
                      )),*/
                ])));
  }
}
