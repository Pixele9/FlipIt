import 'package:flutter/material.dart';
import 'screens/login.dart';

import 'screens/menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Flutter Login", debugShowCheckedModeBanner: false, home: Menu());
  }
}