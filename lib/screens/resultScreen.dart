import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:statistics_calculator/ads/ads.dart';
import 'package:statistics_calculator/screens/stepsScreen.dart';
import 'package:statistics_calculator/screens/charts.dart';
import 'package:statistics_calculator/shered/components.dart';
import 'package:sizer/sizer.dart';

import 'groupData.dart';

const int maxFailedLoadAttempts = 3;

class ResultScreen extends StatefulWidget {
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  BannerAd _ad2;
  InterstitialAd _interstitialAd;
  bool isLoading;
  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdsManager.interstitialAdUnitId2,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_interstitialLoadAttempts <= maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  int _interstitialLoadAttempts = 0;
  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
    _ad2 = BannerAd(
        size: AdSize.banner,
        adUnitId: AdsManager.bannerAdUnitId2,
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
    _ad2.load();
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd.show();
    }
  }

  @override
  void dispose() {
    _ad2?.dispose();
    super.dispose();
    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "Result",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                      fontSize: 24),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              myDivider(),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blue.shade100,
                            blurRadius: 20,
                            offset: Offset(0, 10))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Sorted Data:-",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            )),
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text("$data",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(1, buildResult("Sample Size:", data.length)),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(1.3, buildResult("Mean:", mean())),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(1.6, buildResult("Median:", median(data))),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(1.6, buildResult("Mode:", mode())),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(1.9, buildResult("Range:", range())),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(2.1, buildResult("Variance:", variance())),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(
                  2.4, buildResult("Standard Deviation:", standerdDevation())),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(2.4, buildResult("Coefficient(CV):", cv())),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(
                2.7,
                buildResult("Q1:", q1()),
              ),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(3, buildResult("Q2:", median(data))),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(3.3, buildResult("Q3:", q3())),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(3.6, buildResult("IQR:", iQR())),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(3.9, buildResult("Upper Limit:", uB())),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(4.1, buildResult("Lower Limit:", lB())),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(4.4, buildResult("Outlier:", outlier())),
              SizedBox(
                height: 2.h,
              ),
              FadeAnimation(
                  4.4,
                  InkWell(
                    child: Container(
                      height: 5.h,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              colors: [
                                Colors.blue[900],
                                Colors.blue[700],
                                Colors.blue[500]
                              ])),
                      child: Center(
                        child: Text(
                          "Show Variance Table",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {});
                      varianceTable();
                      navigateTo(context, StepsScreen());
                    },
                  )),
              SizedBox(
                height: 2.h,
              ),
              FadeAnimation(
                  4.8,
                  InkWell(
                    child: Container(
                      height: 5.h,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              colors: [
                                Colors.blue[900],
                                Colors.blue[700],
                                Colors.blue[500],
                              ])),
                      child: Center(
                        child: Text(
                          "Show Graphs",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {});
                      funhistogram(grath());
                      funLiner(graph2());
                      _showInterstitialAd();
                      navigateTo(context, Charts());
                    },
                  )),
              SizedBox(
                height: 10,
              ),
              FadeAnimation(
                  4.8,
                  InkWell(
                    child: Container(
                      height: 5.h,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              colors: [
                                Colors.blue[900],
                                Colors.blue[700],
                                Colors.blue[500],
                              ])),
                      child: Center(
                        child: Text(
                          "Show Group Data",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {});
                      funhistogram(grath());

                      _showInterstitialAd();
                      navigateTo(context, GroupData());
                    },
                  )),
              SizedBox(
                height: 10,
              ),
              bannerAds(_ad2, isLoading),
            ],
          ),
        ),
      ),
    );
  }
}
