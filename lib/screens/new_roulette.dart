import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class Roulette extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

     //Scaffold es la base de MaterialDesign de la ruta (pantalla)
      return Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(),
          //Body representa el body de la ruta
          body: Align(
            child: Text("roulette"),
          )
        );

  }
}