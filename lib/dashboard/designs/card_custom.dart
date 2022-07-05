import 'package:flutter/material.dart';

class CardCustom extends StatelessWidget {

  final double mLeft, mRight, width, height;
  final Widget child;
  

  const CardCustom({
    Key? key, required this.mLeft,
    required this.mRight,
    required this.width,
    required this.height,
    required this.child,
    
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.fromLTRB(mLeft, 3, mRight, 3),
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 135, 135, 155),
        borderRadius:  BorderRadius.circular(12),
        boxShadow: [
        ]
      ), 
      child: child,
    );
  }
}