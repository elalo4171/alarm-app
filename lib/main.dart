import 'package:alarm/config/Routes.dart';
import 'package:alarm/config/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alarm',
      initialRoute: '/',
      onGenerateRoute: routes,
      theme: theme,
    );
  }
}
