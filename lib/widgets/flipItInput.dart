import 'package:flutter/material.dart';

Widget flipItInput(String helperText, [TextEditingController controller]){
  return(TextField(
    // maxLength: 2, Muestra un contador de cuantos cáracteres faltan y eso nes bueno. No sé como quitarlo ¯\(°_o)/¯
    // maxLengthEnforced: true
    controller: controller,
    textAlign: TextAlign.center,
    showCursor: true,
    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
    decoration: InputDecoration(
      border: InputBorder.none, 
      hintText: helperText,
      contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 30),
      ),
  ));
}