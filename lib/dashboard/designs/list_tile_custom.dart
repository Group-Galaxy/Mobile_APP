//import 'package:dashboard_screen/themes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mypart/dashboard/themes.dart';

class ListTileCustom extends StatelessWidget {
  final Color bgColor;
  final String pathIcon, title, subTitle;
  const ListTileCustom({
    Key? key,
    required this.bgColor,
    required this.pathIcon, required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor,
        ),
        
      ),
      title: Text(title,
        style: textBold2,
      ),
      subtitle: Text(subTitle,
        style: textBold,
      ),
    );
  }
}