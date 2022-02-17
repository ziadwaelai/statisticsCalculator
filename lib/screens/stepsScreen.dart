import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:statistics_calculator/ads/ads.dart';
import 'package:statistics_calculator/shered/components.dart';
import 'package:sizer/sizer.dart';

class StepsScreen extends StatefulWidget {
  @override
  _StepsScreenState createState() => _StepsScreenState();
}

class _StepsScreenState extends State<StepsScreen> {
  BannerAd _ad3;
  bool isLoading;
  @override
  void initState() {
    super.initState();
    _ad3 = BannerAd(
        size: AdSize.banner,
        adUnitId: AdsManager.bannerAdUnitId3,
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
    _ad3.load();
  }

  @override
  void dispose() {
    _ad3?.dispose();
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
            height: 20,
          ),
          Center(
              child: FadeAnimation(
                  1.1,
                  Text("Variance Table",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      )))),
          SizedBox(
            height: 10,
          ),
          myDivider(),
          SizedBox(
            height: 10,
          ),
          FadeAnimation(
            1.2,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  color: Colors.blue[100],
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blue.shade100,
                        blurRadius: 20,
                        offset: Offset(10, 10))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    height: 3.h,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(" x",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              )),
                        ),
                        Expanded(
                          child: Text(" x̅",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              )),
                        ),
                        Expanded(
                          child: Text(" (x-x̅)",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              )),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text("  (x-x̅ )",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  )),
                              Text("^2",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          FadeAnimation(
            1.3,
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => sdStepsBuldir(index),
                itemCount: xMinusMean.length),
          ),
          SizedBox(
            height: 30,
          ),
          FadeAnimation(
            1.6,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 4.h,
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage("asstes/images/sd.png"),
                      ),
                      Text(
                        " = ${(variance() * (data.length - 1)).toStringAsFixed(3)} /${data.length - 1} = ${(variance()).toStringAsFixed(3)}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FadeAnimation(1.4, myDivider2()),
          SizedBox(
            height: 30,
          ),
          bannerAds(_ad3, isLoading),
        ],
      ),
    ));
  }
}
