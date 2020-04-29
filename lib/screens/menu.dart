import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import './new_roulette.dart';

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
                                margin: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "Flip It!",
                                  style: cFlipItStyle,
                                ), 
                            ),
                              Container(
                                height: 500,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    _menuButton("New\nRoulette", context),
                                    _menuButton("New\nFlip", context),
                                    _menuButton("Join\nGame", context)
                                  ],
                                  ),
                              ),
                              Expanded(child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Image(
                                  height: 170,
                                  width: 200,
                                  image: AssetImage('assets/standing-19.png'),
                                  fit: BoxFit.fitHeight,
                                  alignment: Alignment.bottomRight,
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

Widget _menuButton(String texto, BuildContext context) {
    return Container(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        decoration: cMenuButtonDecoration,
        child: ButtonTheme(
          height: 140.0,
          minWidth: 300.0,
          splashColor: Colors.grey[350],
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0),
          ),
          child: FlatButton(
            onPressed: () =>  {
            Navigator.of(context).push(_createRoute())
          },
            color: Colors.white,
            child: Container(
              alignment: Alignment.centerLeft,
              width: 250,
              padding: EdgeInsets.all(16.0),
              child: Text(
                texto,
                style: cMenuButtontext,
              )
            )
          ),
        ),
      ),
    );
  }

}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => NewRoulette(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}


