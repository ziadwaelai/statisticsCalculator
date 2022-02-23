import 'package:flutter/material.dart';
import 'package:statistics_calculator/ads/ads.dart';
import 'package:statistics_calculator/screens/resultScreen.dart';
import 'package:statistics_calculator/shered/components.dart';
import 'package:sizer/sizer.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const int maxFailedLoadAttempts = 3;

class FinalHomePage extends StatefulWidget {
  @override
  _FinalHomePageState createState() => _FinalHomePageState();
}

class _FinalHomePageState extends State<FinalHomePage> {
  var formkey = GlobalKey<FormState>();
  BannerAd _ad1;
  bool isLoading;
  InterstitialAd _interstitialAd;

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdsManager.interstitialAdUnitId1,
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
    _ad1 = BannerAd(
        size: AdSize.banner,
        adUnitId: AdsManager.bannerAdUnitId1,
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
    _ad1.load();
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
    _ad1?.dispose();
    super.dispose();
    _interstitialAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.blue[900],
            Colors.blue[800],
            Colors.blue[400]
          ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Padding(
                padding:const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: FadeAnimation(
                          1,
                         const Text(
                            "Statistics",
                            style: TextStyle(color: Colors.white, fontSize: 50),
                          )),
                    ),
                  const  SizedBox(
                      height: 10,
                    ),
                    FadeAnimation(
                        1.3,
                        const Text(
                          "Calculator",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ],
                ),
              ),
            const  SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:const  BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                         const SizedBox(
                            height: 60,
                          ),
                          FadeAnimation(
                              1.4,
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.blue.shade100,
                                          blurRadius: 20,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 200,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        style: TextStyle(fontSize: 18.sp),
                                        keyboardType: TextInputType.number,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                            hintText: "Ex:1,2,3,4,5,6",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "enter the data";
                                          } else if (data.length < 3) {
                                            return "data mustn't be less than 3";
                                          } else if (data[data.length - 1] >=
                                              1000000) {
                                            return "data is too longe";
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            inputControle.text = value;
                                            if (value.isNotEmpty) {
                                              stringTolistData(
                                                  inputControle.text);
                                            }

                                            print(data.length);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                         const SizedBox(
                            height: 40,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          FadeAnimation(
                              1.5,
                              InkWell(
                                child: Container(
                                  height: 50,
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
                                    child:const Text(
                                      "Calculate",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (formkey.currentState.validate()) {
                                    setState(() {});
                                    _showInterstitialAd();
                                    navigateTo(context, ResultScreen());
                                  }
                                },
                              )),
                         const SizedBox(
                            height: 30,
                          ),
                          bannerAds(_ad1, isLoading),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
