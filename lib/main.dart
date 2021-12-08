import 'package:flutter/material.dart';
import 'package:statistics_calculator/screens/stepsScreen.dart';
import 'screens/fianlHomePage.dart';
import 'package:sizer/sizer.dart';
import 'screens/stepsScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Statistics Calculator',
          home: FinalHomePage(),
        );
      },
    );
  }
}
