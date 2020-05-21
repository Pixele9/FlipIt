import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utilities/constants.dart';

//TODO: Individual widgets for stuff in the return statement

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
                                  child: TextField(
                                    // maxLength: 2, Muestra un contador de cuantos cáracteres faltan y eso es bueno. No sé como quitarlo ¯\(°_o)/¯
                                    // maxLengthEnforced: true
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    showCursor: false,
                                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                                    decoration: InputDecoration(
                                      border: InputBorder.none, 
                                      hintText: '0-8',
                                      contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 30),
                                      ),
                                    ),
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
                                  child: TextField(
                                    // maxLength: 2, Muestra un contador de cuantos cáracteres faltan y eso nes bueno. No sé como quitarlo ¯\(°_o)/¯
                                    // maxLengthEnforced: true
                                    textAlign: TextAlign.center,
                                    showCursor: false,
                                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                                    decoration: InputDecoration(
                                      border: InputBorder.none, 
                                      hintText: 'ABC12',
                                      contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 30),
                                      ),
                                  ),
                                ),
                              ],
                            ),),
                              Container(
                              alignment: Alignment.bottomRight,
                              margin: const EdgeInsets.only(right: 20.0),
                              child: Container(
                                decoration: cButtonDecoration,
                                child: ButtonTheme(
                                  height: 53.0,
                                  minWidth: 114.0,
                                  padding: EdgeInsets.all(8.0),
                                  splashColor: Colors.grey[350],
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(100.0),
                                  ),
                                  child: FlatButton(
                                    onPressed: () => print("OK"),
                                    color: Colors.white,
                                    child: Text(
                                      "Create",
                                      style: cLoginButton,
                                      )
                                    ),
                                  ),
                              ),
                            )
                            ]
                              )
                        );
            }),
        )
    );

  }
}