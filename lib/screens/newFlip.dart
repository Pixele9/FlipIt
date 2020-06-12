import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'dart:math';

class NewFlip extends StatefulWidget {
  @override
  _NewFlipState createState() => _NewFlipState();
}

class _NewFlipState extends State<NewFlip> with TickerProviderStateMixin {

  AnimationController _tossController;
  CurvedAnimation _tossAnimation;

  @override
  void initState() {
    super.initState();

    _tossController = AnimationController(vsync: this, duration: Duration(milliseconds: 3000));
    _tossAnimation = CurvedAnimation(parent: _tossController, curve: Curves.easeInOutQuart); 

  }

  @override
  void dispose() {
    _tossController.dispose();
    super.dispose();
  }

	@override
	Widget build(BuildContext context) {
		return Scaffold(
      appBar: AppBar(
        title: Text("Flip a Coin!")
      ),
      // backgroundColor: primaryColor,
      body: GestureDetector(
        onTap: _flipCoinAnimation,
        child: Container(
          child: AnimatedBuilder(
            // animation: _tossAnimation,
            animation: _tossController.view,
            builder: (context, child) {
              // final _value = _tossAnimation.value;
              int rand = Random().nextInt(100) + 1;
              return Container(
                child: _buildCoin(rand),
                // transform: _matrixTransform(),
              );
            },
          ),
        ),
      ),
    );
	}

  _buildCoin(randomValue) {
    var rand = Random().nextDouble();
    const FRONT = "assets/Heads.png";
    const BACK = "assets/Tails.png";  
    String image(_x) {
      int _t = (-_x ~/ (pi / 2)) % 4;
      return _t == 0 || _t == 3 || _t == 4 ? FRONT : BACK;
    }
    double _value = _tossAnimation.value;
    print("VALUE: " + _value.toString());
    double _x = -760 * pi / 180 * _value;
    double _y = 12 * pi / 180 * _value;
    double _z = 30 * pi / 180 * _value;
    Matrix4 _transform = Matrix4.identity()
      ..setEntry(3, 2, 0.002)
      ..rotateX(_x)
      ..rotateY(_y)
      ..rotateZ(_z);
    print("X: $_x");
    print("Y: $_y");
    print("Z: $_z");
    
    return Center(
      child: Container(
        color: Colors.amber,
        transform: _transform,
        child: Image(
        height: 150,
        width: 150,
        image: AssetImage(image(_x)),
        // fit: BoxFit.contain,
          // alignment: Alignment.bottomLeft,
        ),
      ),
    );
  }

  _flipCoinAnimation() {
    // print("Touched!");
    if (!_tossController.isAnimating) {
      _tossController.forward(from: 0.0);
    }
  }
  
  _matrixTransform() {
    double _value = _tossAnimation.value;
    double _x = -760 * pi / 180 * _value;
    double _y = 12 * pi / 180 * _value;
    double _z = 30 * pi / 180 * _value;
    Matrix4 _transform = Matrix4.identity()
      ..rotateX(_x)
      ..rotateY(_y)
      ..rotateZ(_z);
    return _transform;
  }
}