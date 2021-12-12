import 'package:flutter/material.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:statistics_calculator/ads/ads.dart';
import 'package:statistics_calculator/screens/resultScreen.dart';
import 'package:statistics_calculator/shered/components.dart';
import 'package:sizer/sizer.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';

class FinalHomePage extends StatefulWidget {
  @override
  _FinalHomePageState createState() => _FinalHomePageState();
}

class _FinalHomePageState extends State<FinalHomePage> {
  var formkey = GlobalKey<FormState>();
  final _nativeAdController = NativeAdmobController();
  AdmobBannerSize bannerSize;
  AdmobInterstitial interstitialAd;
  @override
  void initState() {
    super.initState();

    //Ads
    interstitialAd = AdmobInterstitial(
      adUnitId: AdsManager.interstitialAdUnitId,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );

    interstitialAd.load();
    _nativeAdController.reloadAd(forceRefresh: true);
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    _nativeAdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: FadeAnimation(
                        1,
                        Text(
                          "Statistics",
                          style: TextStyle(color: Colors.white, fontSize: 50),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Calculator",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
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
                                      onChanged: (value) {
                                        setState(() {
                                          inputControle.text = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
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
                                  child: Text(
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
                                setState(() {});
                                data = [];
                                interstitialAd.show();
                                stringTolistData(inputControle.text);
                                navigateTo(context, ResultScreen());
                              },
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AdmobBanner(
                              adUnitId: AdsManager.bannerAdUnitId,
                              adSize: AdmobBannerSize.ADAPTIVE_BANNER(
                                  width: 80.w.toInt())),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
