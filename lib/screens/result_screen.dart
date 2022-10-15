import 'dart:math';
import 'package:bmi/tools/gender.dart';
import 'package:flutter/material.dart';
import '../tools/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
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
    var local = AppLocalizations.of(context);
    return Scaffold(
        backgroundColor: kBackground,
        appBar: AppBar(
          backgroundColor: kBackground,
          title: Text(AppLocalizations.of(context)?.title ?? '',
              style: kBodyTextStyle),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 180),
                  Text(local?.bmi ?? '', style: kResultTextStyle),
                  const SizedBox(height: 30),
                  Text(_bmi.toStringAsFixed(2), style: kBMITextStyle),
                  const SizedBox(height: 35),
                  Text(_weightLevel(local), style: levelColorStyle),
                  const SizedBox(height: 25),
                  Text(_optimalBMI(local?.optimalBMI ?? ''),
                      style: kOptimalBMIStyle),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                      height: 80,
                      color: kBottomContainerColor,
                      child: Center(
                        child:
                            Text(local?.recalc ?? '', style: kLabelTextStyle),
                      )),
                ),
              )
            ],
          ),
        ));
  }

  String _weightLevel(AppLocalizations? local) {
    int cof = gender == Gender.male ? 1 : 0;

    String weightLevel;
    if (_bmi >= 35.0 + cof) {
      weightLevel = local?.weightL1 ?? '';
      levelColorStyle = kWeightLevel5Style;
    } else if (_bmi >= 30.0 + cof) {
      weightLevel = local?.weightL2 ?? '';
      levelColorStyle = kWeightLevel4Style;
    } else if (_bmi >= 25.0 + cof) {
      weightLevel = local?.weightL3 ?? '';
      levelColorStyle = kWeightLevel3Style;
    } else if (_bmi >= 18.5 + cof) {
      weightLevel = local?.weightL4 ?? '';
      levelColorStyle = kWeightLevel2Style;
    } else {
      weightLevel = local?.weightL5 ?? '';
      levelColorStyle = kWeightLevel1Style;
    }

    return weightLevel;
  }

  String _optimalBMI(String message) {
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
    return "$message: $optimalBMI kg/m2";
  }
}
