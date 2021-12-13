import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:statistics_calculator/ads/ads.dart';
import 'package:statistics_calculator/shered/components.dart';
import 'package:sizer/sizer.dart';

final List<charts.Series<Graph, String>> series = [
  charts.Series(
    id: "1",
    data: graph,
    domainFn: (Graph series, _) => series.x,
    measureFn: (Graph series, _) => series.y,
    fillColorFn: (pollution, _) => charts.ColorUtil.fromDartColor(
      Colors.blue[900],
    ), //column color.
  )
];

class Charts extends StatefulWidget {
  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  BannerAd _ad;
  bool isLoading;
  @override
  void initState() {
    super.initState();
    _ad = BannerAd(
        size: AdSize.banner,
        adUnitId: AdsManager.bannerAdUnitId,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              isLoading = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            print(error);
          },
        ),
        request: AdRequest());
    _ad.load();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          FadeAnimation(
            1.3,
            Text("Histogram",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                )),
          ),
          SizedBox(
            height: 10,
          ),
          FadeAnimation(1.4, myDivider()),
          SizedBox(
            height: 10,
          ),
          FadeAnimation(
            1.6,
            Padding(
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
                  height: 70.h,
                  child: histogram()),
            ),
          ),
          bannerAds(_ad,isLoading),
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
        defaultRenderer: new charts.BarRendererConfig(
          maxBarWidthPx: 30.w.toInt(),
          minBarLengthPx: 10.w.toInt(),
        ),
      ),
    ),
  );
}
