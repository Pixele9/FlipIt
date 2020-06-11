import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../widgets/flipItInput.dart';
import '../widgets/flipitButton.dart';
import './roulette_options.dart';

class NewRoulette extends StatelessWidget {

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
                                  "New Roulette",
                                  style: cTitleViews,
                                ), 
                            ), 
                            SizedBox(
                              height: 500,
                              child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(bottom: 10.0),
                                  width: MediaQuery.of(context).size.width,
                                  child: Container(
                                        alignment: Alignment.center,
                                        width: MediaQuery.of(context).size.width / 2,
                                        margin: const EdgeInsets.only(bottom: 10.0),
                                        child: Text(
                                          "Participants",
                                          style: cLabelStyle,
                                        ), 
                                      ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: 250.0,
                                  decoration: cOptionInputDecoration,
                                  margin: const EdgeInsets.only(bottom: 30.0),
                                  child: flipItInput('0-8')
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width / 2,
                                  margin: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    "Game Code",
                                    style: cLabelStyle,
                                  ), 
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: 250,
                                  decoration: cOptionInputDecoration,
                                  margin: const EdgeInsets.only(bottom: 30.0),
                                  child: flipItInput('ABC12'),
                                ),
                              ],
                            ),),
                              Container(
                              alignment: Alignment.bottomRight,
                              margin: const EdgeInsets.only(right: 20.0),
                              child: flipItButton('Next', () => {
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RouletteOptions()))
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
