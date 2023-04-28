import 'package:bmi_calc/result_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_content.dart';
import 'reuseable_card.dart';
import 'calculate.dart';

const activeCardColor = Color(0xFF1D1E33);
const bottomContainerHeight = 80.0;
const inactiveCardColor = Color(0xFF111328);
const smallTextProperty = TextStyle(fontSize: 18.0, color: Colors.white70);
const largeTextLabel = TextStyle(
    fontSize: 50.0, fontWeight: FontWeight.w700, color: Colors.white70);

enum GenderName { femaleGender, maleGender }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  GenderName? selectedGender;
  int height = 150;
  int weight = 50;
  int age = 20;
  void reduce() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('BMI CALC')),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = GenderName.maleGender;
                      });
                    },
                    child: ReuseableCard(
                      childWidget: IconContent(
                        iconB: FontAwesomeIcons.mars,
                        iconName: 'male',
                      ),
                      colour: selectedGender == GenderName.maleGender
                          ? activeCardColor
                          : inactiveCardColor,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = GenderName.femaleGender;
                      });
                    },
                    child: ReuseableCard(
                      colour: selectedGender == GenderName.femaleGender
                          ? activeCardColor
                          : inactiveCardColor,
                      childWidget: IconContent(
                        iconB: FontAwesomeIcons.venus,
                        iconName: 'female',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ReuseableCard(
            colour: activeCardColor,
            childWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'height',
                  style: smallTextProperty,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      height.toString(),
                      style: largeTextLabel,
                    ),
                    Text(
                      "cm",
                      style: smallTextProperty,
                    )
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.white,
                      thumbColor: Color(0x29EB1555),
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 30.0)),
                  child: Slider(
                    value: height.toDouble(),
                    min: 120.0,
                    max: 220.0,
                    activeColor: Colors.pinkAccent,
                    inactiveColor: Colors.white70,
                    onChanged: (double newHeight) {
                      setState(() {
                        height = newHeight.round();
                      });
                    },
                  ),
                )
              ],
            ),
          )),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ReuseableCard(
                    colour: activeCardColor,
                    childWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'weight',
                            style: smallTextProperty,
                          ),
                          Text(
                            weight.toString(),
                            style: largeTextLabel,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleButton(
                                  icon: FontAwesomeIcons.minus,
                                  addOrReduce: () {
                                    setState(() {
                                      weight--;
                                    });
                                  }),
                              SizedBox(
                                width: 10.0,
                              ),
                              CircleButton(
                                  icon: FontAwesomeIcons.plus,
                                  addOrReduce: () {
                                    setState(() {
                                      weight++;
                                    });
                                  }),
                            ],
                          ),
                        ]),
                  ),
                ),
                Expanded(
                  child: ReuseableCard(
                    colour: activeCardColor,
                    childWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'age',
                            style: smallTextProperty,
                          ),
                          Text(
                            age.toString(),
                            style: largeTextLabel,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleButton(
                                  icon: FontAwesomeIcons.minus,
                                  addOrReduce: () {
                                    setState(() {
                                      age--;
                                    });
                                  }),
                              SizedBox(
                                width: 10.0,
                              ),
                              CircleButton(
                                  icon: FontAwesomeIcons.plus,
                                  addOrReduce: () {
                                    setState(() {
                                      age++;
                                    });
                                  }),
                            ],
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
          ButtomButton(
            buttonName: 'calculate',
            onTap: () {
              Calculate calc = Calculate(weight: weight, height: height);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(
                      bmiResult: calc.calculateBMI(),
                      interpretation: calc.getResult(),
                      normal: calc.getInterpretation(),
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }
}

class ButtomButton extends StatelessWidget {
  ButtomButton({required this.onTap, required this.buttonName});

  String buttonName;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(bottom: 8.0),
        child: Center(
          child: Text(
            buttonName,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
          ),
        ),
        height: 30.0,
        color: Colors.pink,
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  CircleButton({required this.icon, required this.addOrReduce});

  IconData icon;
  final void Function() addOrReduce;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      hoverElevation: 0.0,
      elevation: 0.0,
      onPressed: addOrReduce,
      shape: CircleBorder(),
      constraints: BoxConstraints.tightFor(
        width: 40.0,
        height: 40.0,
      ),
      fillColor: Color(0xFF4C4F5E),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
