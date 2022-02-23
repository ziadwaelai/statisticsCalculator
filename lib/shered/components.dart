import "dart:math";
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:charts_flutter/flutter.dart' as charts;

List<double> data = [];
Graph z;
List xMinusMean = [];
List xMinusMeanSqure = [];
List meanTable = [];
double _mean, _q1, _q3, _variance;
int postion = 0;
int medianPosrionint = 0;
bool isCorrect = true;
TextEditingController inputControle = TextEditingController();
dynamic k = 0, cw = 0, lowBound = data[0];
List low = [], up = [];
List<int> freq = List.filled(k, 0);
List<String> interval = [];
List<charts.Series<Graph, String>> series = [];
List<charts.Series<Linear, int>> series2 = [];

List funhistogram(List _graph) {
  series = [
    charts.Series(
      id: "1",
      data: _graph,
      domainFn: (Graph series, _) => series.x,
      measureFn: (Graph series, _) => series.y,
      fillColorFn: (pollution, _) => charts.ColorUtil.fromDartColor(
        Colors.blue[900],
      ),
      //column color.
    )
  ];
  return series;
}

List funLiner(List _liner) {
  series2 = [
    charts.Series<Linear, int>(
      id: 'liner',
      domainFn: (Linear sales, _) => sales.x,
      measureFn: (Linear sales, _) => sales.y,
      fillColorFn: (pollution, _) =>
          charts.ColorUtil.fromDartColor(Colors.blue[900]),
      data: _liner,
    )
  ];
  return series2;
}

double mean() {
  double sum = 0.0;
  for (int i = 0; i < data.length; i++) {
    sum += data[i];
  }
  _mean = sum / data.length;
  return _mean;
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
  List<double> freq = List.filled(1000000, 0.0);
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
  data = [];
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
  _q1 = median(dataQ1);
  return _q1;
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
  _q3 = median(dataQ3);
  return _q3;
}

double iQR() {
  return _q3 - _q1;
}

double lB() {
  return _q1 - (1.5 * iQR());
}

double uB() {
  return _q3 + (1.5 * iQR());
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
    sum += pow((data[i] - _mean), 2);
  }
  _variance = sum / (data.length - 1);
  return _variance;
}

double standerdDevation() {
  double sd = 0;

  sd += pow(_variance, 0.5);
  return sd;
}

void varianceTable() {
  xMinusMean = [];
  xMinusMeanSqure = [];
  meanTable = [];
  for (int i = 0; i < data.length; i++) {
    xMinusMean.add(data[i] - _mean);
    xMinusMeanSqure.add(pow((data[i] - _mean), 2));
    meanTable.add(_mean);
  }
}

double cv() {
  return (standerdDevation() / _mean) * 100;
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text("${data[i]}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
              Spacer(),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text("${meanTable[i].toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
              Spacer(),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text("${xMinusMean[i].toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
              Spacer(),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text("${xMinusMeanSqure[i].toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class Graph {
  final String x;
  final int y;

  Graph({@required this.x, @required this.y});
}

List grath() {
  low = [];
  up = [];
  interval = [];
  series = [];
  k = 0;
  cw = 0;
  lowBound = data[0];
  low = [];
  up = [];
  //group data
  while (!(pow(2, k) >= data.length)) {
    k++;
  }
  cw = ((data[data.length - 1] - data[0]) / k).roundToDouble() + 1;
  List<Graph> graph = List.filled(k, z);

  freq = List.filled(k, 0);
  for (int i = 0; i < k; i++) {
    low.add(lowBound);
    lowBound += cw;
    up.add(lowBound);
  }

  for (int i = 0; i < k; i++) {
    for (int j = 0; j < data.length; j++) {
      if (data[j] >= low[i] && data[j] < up[i]) {
        freq[i]++;
      }
    }
  }

  for (int i = 0; i < k; i++) {
    String x = "${low[i].toInt()}->${up[i].toInt()}";
    interval.add(x);
  }
  for (int i = 0; i < k; i++) {
    graph[i] = (Graph(x: interval[i], y: freq[i]));
  }

  return graph;
}

List graph2() {
  Linear x;
  List<Linear> grahp2 = List.filled(k + 2, x);
  grahp2[0] = Linear((low[0] - cw).toInt(), 0);
  for (int i = 1; i < k + 1; i++) {
    grahp2[i] =
        (Linear(((up[i - 1] + low[i - 1]) / 2).toInt(), freq[i - 1].toInt()));
  }
  grahp2[k + 1] = Linear((low[low.length - 1] + cw).toInt(), 0);

  print(grahp2);
  return grahp2;
}

Widget bannerAds(BannerAd _ad, bool isLoading) {
  if (isLoading == true) {
    return Container(
      width: _ad.size.width.toDouble(),
      height: _ad.size.height.toDouble(),
      alignment: Alignment.center,
      child: AdWidget(
        ad: _ad,
      ),
    );
  } else {
    return Text("");
  }
}

Widget groupDataSteps(int i) {
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text("${interval[i]}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text("${freq[i]}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class Linear {
  final int x;
  final int y;

  Linear(this.x, this.y);
}
