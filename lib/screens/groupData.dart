import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:statistics_calculator/ads/ads.dart';
import 'package:statistics_calculator/shered/components.dart';
import 'package:sizer/sizer.dart';

class GroupData extends StatefulWidget {
  @override
  State<GroupData> createState() => _GroupDataState();
}

class _GroupDataState extends State<GroupData> {
  BannerAd _ad5;
  bool isLoading;
  @override
  void initState() {
    super.initState();
    _ad5 = BannerAd(
        size: AdSize.banner,
        adUnitId: AdsManager.bannerAdUnitId5,
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
    _ad5.load();
  }

  @override
  void dispose() {
    _ad5?.dispose();
    super.dispose();
  }

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
                    Text("Grouped Data",
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
              height: 20,
            ),
            FadeAnimation(
              1.2,
              Padding(
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
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Container(
                      height: 3.h,
                      width: double.infinity,
                      child: Row(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text("Classes",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                )),
                          ),
                          Spacer(),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text("Frequency (f)",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                )),
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
                  itemBuilder: (context, index) => groupDataSteps(index),
                  itemCount: freq.length),
            ),
            SizedBox(
              height: 20,
            ),
            FadeAnimation(1.4, myDivider2()),
            SizedBox(
              height: 20,
            ),
            bannerAds(_ad5, isLoading),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
