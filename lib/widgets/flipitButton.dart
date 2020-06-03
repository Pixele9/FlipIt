import 'package:flutter/material.dart';
import '../utilities/constants.dart';

Widget flipItButton(String buttonText, Function onPress){
  return(
    Container(
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
        onPressed: onPress,
        color: Colors.white,
        child: Text(
          buttonText,
          style: cLoginButton,
          )
        ),
      ),
    )
  );
}
