import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:statistics_calculator/shered/components.dart';

final List<charts.Series<Graph, String>> series = [
  charts.Series(
    id: "1",
    data: graph,
    domainFn: (Graph series, _) => series.x.toString(),
    measureFn: (Graph series, _) => series.y,
  )
];

class Charts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          FadeAnimation(
            1.3,
            Text("Histogram",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                )),
          ),
          histogram(),
        ],
      ),
    ));
  }
}

Widget histogram() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 500,
      width: double.infinity,
      child: charts.BarChart(
        series,
        animate: true,
      ),
    ),
  );
}
