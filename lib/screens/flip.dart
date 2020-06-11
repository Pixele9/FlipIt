import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../widgets/flipItInput.dart';
import '../widgets/flipitButton.dart';
import 'dart:math';

// class Flip extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {

//      return Scaffold(
//           backgroundColor: Color(0xFFFFFFFF),
//           appBar: AppBar(),
//           body: Align(
//             alignment: Alignment.topCenter,
//             child: LayoutBuilder(
//                 builder: (BuildContext context, BoxConstraints constraints) {
//                     return Container(
//                         width: MediaQuery.of(context).size.width,
//                         height: 100,
//                         alignment: Alignment.center,
//                         color: primaryColor,
//                         child: Text(
//                                   "Flip It!",
//                                   style: cTitleViews,
//                               ), 
//                           );
//                   }),
//             )
//       );
//   }
// }


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

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

  double x = 0;
  double y = 0;
  double z = 0;

  int random = Random().nextInt(100) + 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flip!"),
      ),
      body: GestureDetector(
        onTap: _flipCoinAnimation(),
        child: Center(
          child: AnimatedBuilder(
            animation: _tossController.view, 
            builder: (context, child) {
                // final _value = _tossAnimation.value;
                int rand = Random().nextInt(100) + 1;
                return Container(
                  child: _buildCoin(rand),
                );
              },
            child: Transform(
              transform: Matrix4(
                  1,0,0,0,
                  0,1,0,0,
                  0,0,1,0,
                  0,0,0,1,
              )..setEntry(3, 2, 0.002)..rotateX(x)..rotateY(y)..rotateZ(z),
              alignment: FractionalOffset.center,
              // child: GestureDetector(
              //   onTap: _flipCoinAnimation(),
              //   // onPanUpdate: (details) {
              //   //   setState(() {
              //   //     y = y - details.delta.dx;
              //   //     x = x + details.delta.dy;
              //   //   });
              //   // },
                
              //   // child: Container(
              //   //   color: Colors.red,
              //   //   height: 200.0,
              //   //   width: 200.0,
              //   // ),
              // ),
            ),
          ),
        ),
      ),
    );
  }

  _buildCoin(randomValue) {
    // var rand = Random().nextDouble();
    const FRONT = "assets/Heads.png";
    const BACK = "assets/Tails.png";  
    String image(_x) {
      int _t = (-_x ~/ (pi / 2)) % 4;
      return _t == 0 || _t == 3 || _t == 4 ? FRONT : BACK;
    }
    double _value = _tossAnimation.value;
    print("VALUE: " + _value.toString());
    double _x = -760 * pi / 180 * _value;
    double _y = 120 * pi / 180 * _value;
    double _z = 30 * pi / 180 * _value;
    Matrix4 _transform = Matrix4.identity()
      ..setEntry(3, 2, 0.002)
      ..rotateX(_x)
      ..rotateY(_y)
      ..rotateZ(_z);
    
    y = y + random;
    print(y);

    return Center(
      child: Container(
        // transform: _transform,
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
      _tossController.forward();
    }
  } 

}
