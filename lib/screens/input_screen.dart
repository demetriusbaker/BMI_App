import 'package:bmi/screens/result_screen.dart';
import 'package:bmi/tools/constants.dart';
import 'package:bmi/tools/gender.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

enum Action { plusWeight, minusWeight, plusAge, minusAge }

class _InputPageState extends State<InputPage> {
  Gender? gender;
  int age = 20;
  int height = 170;
  int weight = 70;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kBackground,
        title: Text(local?.title ?? '', style: kBodyTextStyle),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                initGenderImage(Gender.male, local?.male ?? ''),
                initGenderImage(Gender.female, local?.female ?? '')
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(
              child: initHeightImage(local?.height ?? ''),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                initParamImage(local?.weight ?? '', 0, Action.plusWeight,
                    Action.minusWeight),
                initParamImage(
                    local?.age ?? '', 1, Action.plusAge, Action.minusAge),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => openResultScreen(),
            child: Container(
              height: 80,
              color: kBottomContainerColor,
              child: Center(
                  child: Text(
                local?.calc ?? '',
                style: kLargeButtonTextStyle,
              )),
            ),
          )
        ],
      ),
    );
  }

  Expanded initGenderImage(Gender sex, String text) {
    IconData iconData =
        sex == Gender.male ? FontAwesomeIcons.mars : FontAwesomeIcons.venus;
    return Expanded(
        child: ReusableCard(
      onTap: () => setState(() {
        gender = sex;
      }),
      color: gender == sex ? kActiveCardColor : kInactiveCardColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, size: 100),
          const SizedBox(
            height: 20,
          ),
          Text(
            text,
            style: kBodyTextStyle,
          )
        ],
      ),
    ));
  }

  Column initHeightImage(String lable) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            lable,
            style: kBodyTextStyle,
          ),
          Text("${height.toString()} cm", style: kNumberTextStyle),
          Slider(
              min: 130,
              max: 230,
              activeColor: kBottomContainerColor,
              value: height.toDouble(),
              onChanged: (value) => setState(() {
                    height = value.round();
                  }))
        ]);
  }

  Expanded initParamImage(
      String text, int flag, Action action1, Action action2) {
    return Expanded(
        child: ReusableCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: kBodyTextStyle,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            flag == 1 ? age.toString() : weight.toString(),
            style: kNumberTextStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              initButton(action1, FontAwesomeIcons.plus),
              const SizedBox(width: 5),
              initButton(action2, FontAwesomeIcons.minus),
            ],
          )
        ],
      ),
    ));
  }

  RawMaterialButton initButton(Action action, IconData icon) {
    return RawMaterialButton(
      onPressed: () {
        setState(() {
          switch (action) {
            case Action.plusWeight:
              increaseWeight();
              break;
            case Action.minusWeight:
              decreaseWeight();
              break;
            case Action.plusAge:
              increaseAge();
              break;
            case Action.minusAge:
              decreaseAge();
              break;
          }
        });
      },
      shape: const CircleBorder(),
      fillColor: kSmallButtonColor,
      elevation: 10,
      padding: const EdgeInsets.all(5),
      child: Icon(icon),
    );
  }

  void increaseWeight() {
    if (weight >= maximumWeight) return;
    weight++;
  }

  void decreaseWeight() {
    if (weight <= minimalWeight) return;
    weight--;
  }

  void increaseAge() {
    if (age >= maximumAge) return;
    age++;
  }

  void decreaseAge() {
    if (age <= minimalAge) return;
    age--;
  }

  void openResultScreen() {
    gender ??= Gender.male;

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultPage(
                  gender: gender,
                  weight: weight,
                  age: age,
                  height: height,
                )));
  }
}

class ReusableCard extends StatelessWidget {
  final Color color;
  final Widget? child;
  final VoidCallback? onTap;

  const ReusableCard({
    Key? key,
    this.color = kInactiveCardColor,
    this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
        child: child,
      ),
    );
  }
}
