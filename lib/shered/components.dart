import "dart:math";
import 'package:flutter/rendering.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

List<double> data = [];
List xMinusMean = [];
List xMinusMeanSqure = [];
List meanTable = [];
int postion = 0;
int medianPosrionint = 0;
bool isCorrect = true;
TextEditingController inputControle = TextEditingController();

double mean() {
  double sum = 0.0;
  for (int i = 0; i < data.length; i++) {
    sum += data[i];
  }
  return (sum / data.length);
}

void medianPosrion() {
  if (data.length % 2 == 0) {
    medianPosrionint = ((data.length / 2)).toInt();
  } else {
    medianPosrionint = ((data.length + 1) / 2).toInt();
  }
}

double median(List data) {
  medianPosrion();
  List copyData = data;
  if (copyData.length % 2 == 0) {
    postion = ((copyData.length / 2)).toInt();

    return (copyData[postion - 1] + copyData[postion]) / 2;
  } else {
    postion = ((copyData.length + 1) / 2).toInt();
    return copyData[postion - 1];
  }
}

String mode() {
  List<double> copyData = data;
  List<double> freq = List.filled(100000000, 0.0);
  List<double> freq2 = [];
  List<double> modeArre = [];
  for (int i = 0; i < copyData.length; i++) {
    freq[copyData[i].toInt()]++;
  }
  double max = 0;
  for (int i = 0; i < freq.length; i++) {
    if (freq[i] != 0) {
      freq2.add(freq[i]);
    }
  }
  for (int i = 0; i < freq2.length; i++) {
    if (max < freq2[i]) {
      max = freq2[i];
    }
  }
  final copyData2 = copyData.toSet().toList();
  for (int i = 0; i < freq2.length; i++) {
    if (max == freq2[i]) {
      modeArre.add(copyData2[i]);
    }
  }
  if (max == 1) {
    return "No mode";
  }
  return modeArre.toString();
}

void stringTolistData(String inputData) {
  String num = "";
  String copyInputData = inputData;
  copyInputData = copyInputData.replaceAll(' ', '');

  if (copyInputData[copyInputData.length - 1] != ',') {
    copyInputData += ",";
  }
  for (int i = 0; i < copyInputData.length; i++) {
    if (copyInputData[i] != ',') {
      num += copyInputData[i];
    } else {
      data.add(double.parse(num));
      num = "";
    }
  }
  data.sort();
}

double range() {
  double max = data.last;
  double min = data[0];
  return max - min;
}

double q1() {
  List dataQ1 = [];
  for (int i = 0; i < medianPosrionint - 1; i++) {
    dataQ1.add(data[i]);
  }
  return median(dataQ1);
}

double q3() {
  List dataQ3 = [];
  if (data.length % 2 != 0) {
    for (int i = medianPosrionint; i < data.length; i++) {
      dataQ3.add(data[i]);
    }
  } else {
    for (int i = medianPosrionint + 1; i < data.length; i++) {
      dataQ3.add(data[i]);
    }
  }
  return median(dataQ3);
}

double iQR() {
  return q3() - q1();
}

double lB() {
  return q1() - (1.5 * iQR());
}

double uB() {
  return q3() + (1.5 * iQR());
}

dynamic outlier() {
  if (data[data.length - 1] > uB()) {
    return data[data.length - 1];
  } else {
    return "No outlier";
  }
}

double variance() {
  double sum = 0;
  for (int i = 0; i < data.length; i++) {
    sum += pow((data[i] - mean()), 2);
  }
  return sum / (data.length - 1);
}

double standerdDevation() {
  double sd = 0;

  sd += pow(variance(), 0.5);
  return sd;
}

void varianceTable() {
  xMinusMean = [];
  xMinusMeanSqure = [];
  meanTable = [];
  for (int i = 0; i < data.length; i++) {
    xMinusMean.add(data[i] - mean());
    xMinusMeanSqure.add(pow((data[i] - mean()), 2));
    meanTable.add(mean());
  }
}

double cv() {
  return (standerdDevation() / mean()) * 100;
}

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity")
          .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
          Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
          curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
            offset: Offset(0, animation["translateY"]), child: child),
      ),
    );
  }
}

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0, end: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[900],
          borderRadius: BorderRadius.circular(50),
        ),
        width: double.infinity,
        height: 5.0,
      ),
    );
Widget myDivider2() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0, end: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[900],
          borderRadius: BorderRadius.circular(50),
        ),
        width: double.infinity,
        height: 3.0,
      ),
    );

Widget buildResult(String name, dynamic lable) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.blue.shade100,
                blurRadius: 20,
                offset: Offset(0, 10))
          ]),
      width: double.infinity,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text("$name",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
            Spacer(),
            Container(
              width: 30.w,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text("$lable",
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget sdStepsBuldir(int i) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
              color: Colors.blue.shade100,
              blurRadius: 20,
              offset: Offset(0, 10))
        ],
        color: i % 2 == 0 ? Colors.white : Colors.blue[100],
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          height: 3.h,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: Text("${data[i]}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              Spacer(),
              Expanded(
                child: Text("${meanTable[i]}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              Spacer(),
              Expanded(
                child: Text("${xMinusMean[i]}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              Spacer(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text("${xMinusMeanSqure[i]}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget xbar(double size) {
  return Column(
    children: [
      Text("__",
          style: TextStyle(
            color: Colors.black,
            fontSize: size,
            fontWeight: FontWeight.w600,
          )),
      Text("X",
          style: TextStyle(
            color: Colors.black,
            fontSize: size,
            fontWeight: FontWeight.w600,
          ))
    ],
  );
}
