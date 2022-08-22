import 'package:bmi_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const InputPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

enum Gender { male, female }

enum Action { plusWeight, minusWeight, plusAge, minusAge }

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender? gender;
  int age = 20;
  int height = 150;
  int weight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kBackground,
        title: const Text(appName, style: kBodyTextStyle),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                initGenderImage(Gender.male, "MALE"),
                initGenderImage(Gender.female, "FEMALE")
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(
              child: initHeightImage(),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                initParamImage('WEIGHT', Action.plusWeight, Action.minusWeight),
                initParamImage('AGE', Action.plusAge, Action.minusAge),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded initGenderImage(Gender sex, String text) => Expanded(
          child: ReusableCard(
        onTap: () => setState(() {
          gender = sex;
        }),
        color: gender == sex ? kActiveCardColor : kInactiveCardColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(FontAwesomeIcons.mars, size: 100),
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

  Column initHeightImage() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'HEIGHT',
              style: kBodyTextStyle,
            ),
            Text("${height.toString()} cm", style: kNumberTextStyle),
            Slider(
                min: 130,
                max: 220,
                activeColor: kBottomContainerColor,
                value: height.toDouble(),
                onChanged: (value) => setState(() {
                      height = value.round();
                    }))
          ]);

  Expanded initParamImage(String text, Action action1, Action action2) =>
      Expanded(
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
              weight.toString(),
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

  RawMaterialButton initButton(Action action, IconData icon) =>
      RawMaterialButton(
        onPressed: () {
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
        },
        shape: const CircleBorder(),
        fillColor: kSmallButtonColor,
        elevation: 10,
        padding: const EdgeInsets.all(5),
        child: Icon(icon),
      );

  void increaseWeight() {
    setState(() => weight++);
  }

  void decreaseWeight() {
    setState(() => weight--);
  }

  void increaseAge() {
    setState(() => age++);
  }

  void decreaseAge() {
    setState(() => age--);
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
