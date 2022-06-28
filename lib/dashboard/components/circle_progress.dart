import 'dart:math';

import 'package:flutter/material.dart';

class CircleProgress extends CustomPainter {

CircleProgress();

  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCircle = Paint()
          ..strokeWidth = 3
          ..color = Color.fromARGB(255, 151, 151, 152)
          ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
          ..strokeWidth = 5
          ..color = Color.fromARGB(255, 45, 156, 92)
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width/2 , size.height/2);
    double radius = min(size.width/2, size.height/2 )-7;

    canvas.drawCircle(center, radius, outerCircle);
    double angle = 2 * pi * ( 85/100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi/2, angle, false, completeArc);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}