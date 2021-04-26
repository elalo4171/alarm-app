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

    //
    // Rotation of all widget
    //

    var angle = Vector.radians(-90);
    final double r =
        sqrt(size.width * size.width + size.height * size.height) / 2;
    final alpha = atan(size.height / size.width);
    final beta = alpha + angle;
    final shiftY = r * sin(beta);
    final shiftX = r * cos(beta);
    final translateX = size.width / 2 - shiftX;
    final translateY = size.height / 2 - shiftY;
    canvas.translate(translateX, translateY);
    canvas.rotate(angle);

    DateTime now = DateTime.now();
    path.moveTo(size.width * .5, 25);
    path.lineTo(size.width * 0.5, 45);
    path.moveTo(size.width - 25, size.height * .5);
    path.lineTo(size.width - 45, size.height * 0.5);
    path.moveTo(size.width * .5, size.height - 25);
    path.lineTo(size.width * 0.5, size.height - 45);
    path.moveTo(25, size.height * .5);
    path.lineTo(45, size.height * .5);
    canvas.drawPath(path, paint);

    //Center of clock
    var center = Offset(size.width / 2, size.height / 2);

    /**
     * Hour line and pre line
     */
    final hourP1 = center;

    double hourDegree = 360 / 12 * now.hour;
    // x = cx + r * cos(a)
    x = (size.width / 2) + (size.width / 3) * cos(Vector.radians(hourDegree));
    // y = cy + r * sin(a)
    y = (size.height / 2) + (size.width / 3) * sin(Vector.radians(hourDegree));

    final hourP2 = Offset(x, y);

    paint.color = Colors.black;

    paint.strokeWidth = 2;
    canvas.drawLine(hourP1, hourP2, paint);

    double xSub = (size.width / 2) +
        (-size.width / 3 + 95) * cos(Vector.radians(hourDegree));
    double ySub = (size.height / 2) +
        (-size.width / 3 + 95) * sin(Vector.radians(hourDegree));
    final hourPSub = Offset(xSub, ySub);
    canvas.drawLine(hourP1, hourPSub, paint);
    /**
     * End Hour line and pre line
     */

    /**
     * Minute line and pre line
     */
    final minutesP1 = center;

    double minutesDegree = 360 / 60 * now.minute;
    // x = cx + r * cos(a)
    x = (size.width / 2) +
        (size.width / 3 + 15) * cos(Vector.radians(minutesDegree));
    // y = cy + r * sin(a)
    y = (size.height / 2) +
        (size.width / 3 + 15) * sin(Vector.radians(minutesDegree));

    final minutesP2 = Offset(x, y);

    paint.color = Colors.black;

    paint.strokeWidth = 2;
    canvas.drawLine(minutesP1, minutesP2, paint);

    xSub = (size.width / 2) +
        (-size.width / 3 + 95) * cos(Vector.radians(minutesDegree));
    ySub = (size.height / 2) +
        (-size.width / 3 + 95) * sin(Vector.radians(minutesDegree));
    final minutesPSub = Offset(xSub, ySub);
    canvas.drawLine(minutesP1, minutesPSub, paint);
    /**
     * End Minute line and pre line
     */

    /**
     * Seconds line and pre line
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
    xSub = (size.width / 2) +
        (-size.width / 3 + 95) * cos(Vector.radians(secondDegree));
    ySub = (size.height / 2) +
        (-size.width / 3 + 95) * sin(Vector.radians(secondDegree));
    final secondsPSub = Offset(xSub, ySub);
    canvas.drawLine(secondsP1, secondsPSub, paint);
    /**
     * End of seconds line
     */

    /**
     * Circle of center
     */
    paint.color = Colors.white;
    paint.strokeWidth = 0;
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(center, 2, paint);
  }

  @override
  bool shouldRepaint(MyClockPainter oldDelegate) => true;
}
