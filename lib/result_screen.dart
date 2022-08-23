import 'dart:math';

import 'package:bmi_app/main.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class ResultPage extends StatelessWidget {
  late Gender? gender;
  late int age;
  late int height;
  late int weight;
  double _bmi = 0.0;
  late TextStyle levelColorStyle;

  ResultPage(
      {Key? key,
      required this.gender,
      required this.age,
      required this.height,
      required this.weight})
      : super(key: key) {
    _bmi = weight / pow(height / 100.0, 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackground,
        appBar: AppBar(
          backgroundColor: kBackground,
          title: const Text(appName, style: kBodyTextStyle),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 180),
                  const Text("Your BMI IS", style: kResultTextStyle),
                  const SizedBox(height: 30),
                  Text(_bmi.toStringAsFixed(2), style: kBMITextStyle),
                  const SizedBox(height: 35),
                  Text(_weightLevel(), style: levelColorStyle),
                  const SizedBox(height: 25),
                  Text(_optimalBMI(), style: kOptimalBMIStyle),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                      height: 80,
                      color: kBottomContainerColor,
                      child: const Center(
                        child:
                            Text("RECALCULATE MY BMI", style: kLabelTextStyle),
                      )),
                ),
              )
            ],
          ),
        ));
  }

  String _weightLevel() {
    int cof = gender == Gender.male ? 1 : 0;

    String weightLevel;
    if (_bmi >= 35.0 + cof) {
      weightLevel = "sereve obesity";
      levelColorStyle = kWeightLevel5Style;
    } else if (_bmi >= 30.0 + cof) {
      weightLevel = "obesity";
      levelColorStyle = kWeightLevel4Style;
    } else if (_bmi >= 25.0 + cof) {
      weightLevel = "overweight";
      levelColorStyle = kWeightLevel3Style;
    } else if (_bmi >= 18.5 + cof) {
      weightLevel = "normal weight";
      levelColorStyle = kWeightLevel2Style;
    } else {
      weightLevel = "underweight";
      levelColorStyle = kWeightLevel1Style;
    }

    return weightLevel;
  }

  String _optimalBMI() {
    String optimalBMI;
    if (age < 19) {
      optimalBMI = "18-23";
    } else if (age >= 19 && age <= 24) {
      optimalBMI = "19-24";
    } else if (age >= 25 && age <= 34) {
      optimalBMI = "20-25";
    } else if (age >= 35 && age <= 44) {
      optimalBMI = "21-26";
    } else if (age >= 45 && age <= 54) {
      optimalBMI = "22-27";
    } else if (age >= 55 && age <= 64) {
      optimalBMI = "23-28";
    } else {
      optimalBMI = "24-29";
    }
    return "Optimal bmi for $age years old: $optimalBMI kg/m2";
  }
}
