import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../widgets/flipItInput.dart';
import '../widgets/flipitButton.dart';
import './roulette_status.dart';

class JoinGame extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

     return Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: primaryColor,
          appBar: AppBar(),
          body: Align(
            alignment: Alignment.topCenter,
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                    return SingleChildScrollView(
                      child: Container(
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
                                "Join Game",
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
                                        "Game Code:",
                                        style: cLabelStyle,
                                      ), 
                                    ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 250.0,
                                decoration: cOptionInputDecoration,
                                margin: const EdgeInsets.only(bottom: 30.0),
                                child: flipItInput('ABC12', controller)
                              ),
                            ],
                          ),),
                            Container(
                            alignment: Alignment.bottomRight,
                            margin: const EdgeInsets.only(right: 20.0),
                            child: flipItButton('Join', () => {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RouletteStatus(controller.text)))
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
