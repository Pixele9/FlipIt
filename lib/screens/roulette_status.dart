import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../utilities/authentication.dart';
import '../widgets/flipitButton.dart';
import 'dart:async';

class RouletteStatus extends StatefulWidget {
  @override
  _RouletteStatusState createState() => new _RouletteStatusState();
 }
class _RouletteStatusState extends State<RouletteStatus> {
  //DATA
  var white = Colors.white;
  String status = "Cargando...";
  
  @override
  Widget build(BuildContext context) {
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
                        child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Roulette Status",
                                        style: cStatusTitleStyle,
                                      ),
                                      Text(
                                        status,
                                        style: cStatusStyle,
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

