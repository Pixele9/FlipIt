import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../widgets/flipItInput.dart';
import '../widgets/flipitButton.dart';
import './roulette.dart';
import '../utilities/items.dart';

class RouletteOptionsList{
  final List<String> options;
  String code;

  RouletteOptionsList(this.options, this.code);
}


class RouletteOptions extends StatelessWidget {
  List<TextEditingController> textControllerArray = [TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController()];
  String code;
  RouletteOptions(this.code); 

  void dispose() {
    textControllerArray[0].dispose();
    textControllerArray[1].dispose();
    textControllerArray[2].dispose();
    textControllerArray[3].dispose();
    textControllerArray[4].dispose();
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
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                            Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "Roulette Options",
                                  style: cTitleViews,
                                  textAlign: TextAlign.center,
                                ), 
                            ), 
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
                                    child: Text(
                                      "Write up to 5 options for the roulette to choose!",
                                      textAlign: TextAlign.center,
                                      style: cLabelStyle,
                                    ), 
                                  ),
                            ),
                            SizedBox(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  rouletteOption('1', textControllerArray[0]),
                                  rouletteOption('2', textControllerArray[1]),
                                  rouletteOption('3', textControllerArray[2]),
                                  rouletteOption('4', textControllerArray[3]),
                                  rouletteOption('5', textControllerArray[4]),
                              ],)
                            ),
                              Container(
                              alignment: Alignment.bottomRight,
                              margin: const EdgeInsets.only(right: 20.0),
                              child: flipItButton('Create', () {
                                  if(textControllerArray[0].text != '' && textControllerArray[1].text != ''){
                                    int colorCounter = 0;
                                    List<Item> userOptions = [];

                                    textControllerArray.forEach((item){
                                      if(item.text != ''){
                                        userOptions.add(Item(item.text, Colors.accents[colorCounter]));
                                      }
                                      colorCounter++;
                                    });

                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                        return RoulettePage(userOptions, code);
                                      }
                                    ));
                                  } else {
                                    final snackBar = SnackBar(
                                    content: Text('Please enter at least two options')
                                    ); 

                                    Scaffold.of(context).showSnackBar(snackBar);
                                  }
                              }),
                              )
                            ]
                      )
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
        height: 70,
        decoration: cOptionInputDecoration,
        margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
        child: flipItInput('Option '+optionNumber, optionController),
    )
    ],);
}
