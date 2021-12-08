import 'package:flutter/material.dart';
import 'screens/fianlHomePage.dart';
import 'package:sizer/sizer.dart';

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
