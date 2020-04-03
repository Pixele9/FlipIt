import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      //Scaffold es la base de MaterialDesign de la ruta (pantalla)
      return Scaffold(
          backgroundColor: primaryColor,
          //Body representa el body de la ruta
          body: Align(
          //Esta propiedad de la widget Align alinea todo el contenido en la parte superior y al centro 
            alignment: Alignment.topCenter,
            //Lo importante de la widget LayoutBuilder es que esta widget se adapta al tamaño de la widget padre
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        color: primaryColor,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              SizedBox(height: 40.0),
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(top: 30.0, bottom: 50.0),
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "Flip It!",
                                  style: cFlipItStyle,
                                ), 
                            ),
                            Container(
                              height: 500.0,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  _menuButton("New\nRoulette", context),
                                  _menuButton("New\nFlip Toss", context),
                                  _menuButton("Join\nGame", context)
                                ],
                                ),
                            ),
                          ]
                        )
                    );
            }),
        )
    );
  }
}

Widget _menuButton(String texto, BuildContext context) {
    return Container(
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        decoration: cMenuButtonDecoration,
        child: ButtonTheme(
          height: 120.0,
          minWidth: 300.0,
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
          splashColor: Colors.grey[200],
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0),
          ),
          child: FlatButton(
            onPressed: () => print("Botón :)"),
            color: Colors.white,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                texto,
                style: cMenuButtonsText,
              ),
            )
            ),
          ),
      ),
    );
  }

