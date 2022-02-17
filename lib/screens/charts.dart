import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:statistics_calculator/ads/ads.dart';
import 'package:statistics_calculator/shered/components.dart';
import 'package:sizer/sizer.dart';

class Charts extends StatefulWidget {
  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  BannerAd _ad4;
  bool isLoading;
  @override
  void initState() {
    super.initState();
    _ad4 = BannerAd(
        size: AdSize.banner,
        adUnitId: AdsManager.bannerAdUnitId4,
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
    _ad4.load();
  }

  @override
  void dispose() {
    _ad4?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 15,
          ),
          FadeAnimation(
            1.3,
            Center(
              child: Text("Histogram",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  )),
            ),
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
          SizedBox(
            height: 20,
          ),
          FadeAnimation(
            1.3,
            Center(
              child: Text("Polygon",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FadeAnimation(1.4, myDivider()),
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
                  child: liner()),
            ),
          ),
          bannerAds(_ad4, isLoading),
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
          maxBarWidthPx: 35.w.toInt(),
          minBarLengthPx: 10.w.toInt(),
        ),
      ),
    ),
  );
}

Widget liner() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 500,
      width: double.infinity,
      child: charts.LineChart(
        series2,
        animate: true,
        defaultRenderer: new charts.LineRendererConfig(
            includeArea: true,
            stacked: true,
            includeLine: true,
            radiusPx: 5.0,
            strokeWidthPx: 5,
            includePoints: true),
      ),
    ),
  );
}
