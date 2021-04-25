import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:vector_math/vector_math_64.dart' as Vector;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color gradientStart = Color(0xffF2F3F8);

  final Color gradientEnd = Color(0xffE3E8EF);

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (Timer t) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarm', style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [gradientStart, gradientEnd],
              begin: const FractionalOffset(-0.2, 0.3),
              end: const FractionalOffset(0.0, 0.5),
              stops: [0.0, 18.0],
              tileMode: TileMode.clamp),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  lightSource: LightSource.top,
                  border: NeumorphicBorder(
                      isEnabled: true,
                      color: Colors.grey.withOpacity(.02),
                      width: 2.5),
                  intensity: .5,
                  surfaceIntensity: 0,
                  // shadowLightColorEmboss: Colors.black.withOpacity(.5),
                  // shadowDarkColorEmboss: Colors.black.withOpacity(.5),
                  depth: -51,
                  color: Color(0xFFEFF4FD),
                  boxShape: NeumorphicBoxShape.circle(),
                ),
                child: Container(
                  width: size.size.width * .8,
                  height: size.size.width * .8,
                  child: CustomPaint(
                    painter: MyClockPainter(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = Colors.grey.withOpacity(.5)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final path = new Path();
    path.moveTo(size.width * .5, 25);
    path.lineTo(size.width * 0.5, 45);
    path.moveTo(size.width - 25, size.height * .5);
    path.lineTo(size.width - 45, size.height * 0.5);
    path.moveTo(size.width * .5, size.height - 25);
    path.lineTo(size.width * 0.5, size.height - 45);
    path.moveTo(25, size.height * .5);
    path.lineTo(45, size.height * .5);
    canvas.drawPath(path, paint);
    DateTime now = DateTime.now();
    var center = Offset(size.width / 2, size.height / 2);
    paint.color = Colors.white;
    paint.strokeCap = StrokeCap.round;

    /**
     * Seconds line
     */
    final secondsP1 = center;
    double secondDegree = 360 / 60 * now.second;
    // x = cx + r * cos(a)
    double x = (size.width / 2) +
        (size.width / 3 + 30) * cos(Vector.radians(secondDegree));
    // y = cy + r * sin(a)
    double y = (size.height / 2) +
        (size.width / 3 + 30) * sin(Vector.radians(secondDegree));

    final secondsP2 = Offset(x, y);

    paint.color = Colors.red.withOpacity(.7);

    paint.strokeWidth = 2;
    canvas.drawLine(secondsP1, secondsP2, paint);
    double xSub = (size.width / 2) +
        (-size.width / 3 + 92) * cos(Vector.radians(secondDegree));
    // y = cy + r * sin(a)
    double ySub = (size.height / 2) +
        (-size.width / 3 + 92) * sin(Vector.radians(secondDegree));
    final secondsPSub = Offset(xSub, ySub);
    canvas.drawLine(secondsP1, secondsPSub, paint);

    paint.color = Colors.white;
    paint.strokeWidth = 0;
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(center, 4, paint);
  }

  @override
  bool shouldRepaint(MyClockPainter oldDelegate) => true;
}
