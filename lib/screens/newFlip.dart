import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'dart:math';

class NewFlip extends StatefulWidget {
  @override
  _NewFlipState createState() => _NewFlipState();
}

class _NewFlipState extends State<NewFlip> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

    var _tossController = AnimationController(vsync: this, duration: Duration(milliseconds: 3000));
    var _tossAnimation = CurvedAnimation(parent: _tossController, curve: Curves.easeInOutQuart); 
    double _value = _tossAnimation.value;
    double _x = -760 * pi / 180 * _value;
    double _y = 12 * pi / 180 * _value;
    double _z = 30 * pi / 180 * _value;
    Matrix4 _transform = Matrix4.identity()
      ..rotateX(_x)
      ..rotateY(_y)
      ..rotateZ(_z);
  }

  static const FRONT = "assets/Heads.png";
  static const BACK = "assets/Tails.png";  
  String image(_x) {
    int _t = (-_x ~/ (pi / 2)) % 4;
    return _t == 0 || _t == 3 || _t == 4 ? FRONT : BACK;
  }

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      appBar: AppBar(
        title: Text("Flip a Coin!")
      ),
      // backgroundColor: primaryColor,
      body: GestureDetector(
        child: Container(
            child: Center(
              child: Image(
                height: 150,
                width: 150,
                image: AssetImage(image(29.26)) ,
                fit: BoxFit.contain,
                alignment: Alignment.bottomLeft,
              ),
            )
        ),
      ),
    );
	}
}
