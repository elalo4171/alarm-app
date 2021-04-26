import 'dart:async';
import 'package:alarm/config/Painter/clock_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color gradientStart = Color(0xffF2F3F8);

  final Color gradientEnd = Color(0xffE3E8EF);
  String _timeString;
  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);
    final _theme = Theme.of(context);
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
                    child: Stack(
                      children: [
                        Container(
                          width: size.size.width * .8,
                          height: size.size.width * .8,
                          child: Column(
                            children: [
                              Spacer(),
                              Neumorphic(
                                style: NeumorphicStyle(
                                  shape: NeumorphicShape.concave,
                                  depth: -1,
                                  border: NeumorphicBorder(isEnabled: false),
                                  color: Colors.transparent,
                                  intensity: 3,
                                  boxShape: NeumorphicBoxShape.circle(),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.wb_sunny_sharp,
                                    color: _theme.primaryColor,
                                  ),
                                ),
                              ),
                              Spacer(
                                flex: 2,
                              ),
                              Neumorphic(
                                style: NeumorphicStyle(
                                  shape: NeumorphicShape.concave,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(15)),
                                  depth: -1,
                                  border: NeumorphicBorder(isEnabled: false),
                                  color: Colors.transparent,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 7.0, horizontal: 13.0),
                                  child: Text(
                                    _timeString,
                                    style: TextStyle(color: Color(0xffB4B5BB)),
                                  ),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        Container(
                          width: size.size.width * .8,
                          height: size.size.width * .8,
                          child: CustomPaint(
                            painter: MyClockPainter(),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
