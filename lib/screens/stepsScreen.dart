import 'package:flutter/material.dart';
import 'package:statistics_calculator/shered/components.dart';
import 'package:sizer/sizer.dart';

class StepsScreen extends StatefulWidget {
  @override
  _StepsScreenState createState() => _StepsScreenState();
}

class _StepsScreenState extends State<StepsScreen> {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 5.h,
                width: 5.w,
                child: Row(
                  children: [
                    Image(
                      image: AssetImage("asstes/images/sd.png"),
                    ),
                    Text(
                      " = ${double.parse((variance() * (data.length - 1)).toStringAsFixed(3))} /${data.length - 1} = ${double.parse((variance()).toStringAsFixed(3))}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
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
        ],
      ),
    ));
  }
}
