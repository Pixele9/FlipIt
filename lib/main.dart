import 'package:flutter/material.dart';
import 'utilities/authentication.dart';
import 'screens/newFlip.dart';
import 'screens/animation.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(title: "Flip It!", debugShowCheckedModeBanner: false, home: new AuthenticationWidget());
    return MaterialApp(title: "Flip It!", debugShowCheckedModeBanner: false, home: NewFlip());
  }
} 