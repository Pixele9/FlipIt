import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../widgets/flipItInput.dart';
import '../widgets/flipitButton.dart';
import './roulette.dart';
import '../utilities/items.dart';

class RouletteOptionsList{
  final List<String> options;

  RouletteOptionsList(this.options);
}


class RouletteOptions extends StatelessWidget {
  
  final option1Controller = TextEditingController();
  final option2Controller = TextEditingController();
  final option3Controller = TextEditingController();
  final option4Controller = TextEditingController();
  final option5Controller = TextEditingController();

  void dispose() {
    option1Controller.dispose();
    option2Controller.dispose();
    option3Controller.dispose();
    option4Controller.dispose();
    option5Controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

     return Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(),
          body: Align(
            alignment: Alignment.topCenter,
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        color: primaryColor,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                            Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(top: 30.0),
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "Roulette Options",
                                  style: cTitleViews,
                                ), 
                            ), 
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
                                    child: Text(
                                      "Write 4 options for the roulette to choose!",
                                      textAlign: TextAlign.center,
                                      style: cLabelStyle,
                                    ), 
                                  ),
                            ),
                            SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  rouletteOption('1', option1Controller),
                                  rouletteOption('2', option2Controller),
                                  rouletteOption('3', option3Controller),
                                  rouletteOption('4', option4Controller),
                                  rouletteOption('5', option5Controller),
                              ],)
                            ),
                              Container(
                              alignment: Alignment.bottomRight,
                              margin: const EdgeInsets.only(right: 20.0),
                              child: flipItButton('Create', () {
                                  List<Item> items = [
                                      Item(option1Controller.text, Colors.accents[0]),
                                      Item(option2Controller.text, Colors.accents[1]),
                                      Item(option3Controller.text, Colors.accents[2]),
                                      Item(option4Controller.text, Colors.accents[3]),
                                      Item(option5Controller.text, Colors.accents[4]),
                                    ];
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RoulettePage(items)));
                              }),
                              )
                            ]
                              )
                        );
            }),
        )
    );

  }
}

Widget rouletteOption(String optionNumber, TextEditingController optionController){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        alignment: Alignment.center,
        width: 300,
        decoration: cOptionInputDecoration,
        margin: const EdgeInsets.only(bottom: 20.0, left: 10.0, right: 10.0),
        child: flipItInput('Option '+optionNumber, optionController),
    )
    ],);
}
