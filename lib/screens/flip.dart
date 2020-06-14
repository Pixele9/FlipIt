import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../widgets/flipItInput.dart';
import '../widgets/flipitButton.dart';
import 'dart:math';

// THIS WAS THE TESTING VIEW

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


class CoinToss extends StatefulWidget {
  @override
  _CoinTossState createState() => _CoinTossState();
}

class _CoinTossState extends State<CoinToss> with SingleTickerProviderStateMixin {

  AnimationController _tossController;
  CurvedAnimation _tossAnimation;

  @override
  void initState() {
    super.initState();

    _tossController = AnimationController(vsync: this, duration: Duration(milliseconds: 2000));
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

  // int random = Random().nextInt(100) + 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coin Toss"),
      ),
      body: GestureDetector(
        onTap: _flipCoinAnimation,
        child: Container(
          child: AnimatedBuilder(
            animation: _tossController.view, 
            builder: (context, child) {
                // final _value = _tossAnimation.value;
                // int rand = Random().nextInt(100) + 1;
                return Container(
                  child: _buildCoin(),
                );
              },
            // ),
          ),
        ),
      ),
    );
  }

  _buildCoin() {
    // int randFace = Random().nextInt(90)+10;
    int randFace = Random().nextInt(90)+10;
    const FRONT = "assets/Heads.png";
    const BACK = "assets/Tails.png";  
    String image(_x) {
      int _t = (-_x ~/ (pi / 2)) % 4;
      return _t == 0 || _t == 3 || _t == 4 ? FRONT : BACK;
    }

    double _value = _tossAnimation.value;
    print("VALUE: $_value");
    double _x = -760 * pi / 180 * _value;
    double _y = 12 * pi / 180 * _value;
    double _z = 30 * pi / 180 * _value;
    Matrix4 _transform = Matrix4.identity()
      ..setEntry(3, 2, 0.002)
      ..rotateX(_x)
      ..rotateY(_y)
      ..rotateZ(_z);
    
    Matrix4 _pmat(num pv) {
        return new Matrix4(
          1.0, 0.0, 0.0, 0.0, //
          0.0, 1.0, 0.0, 0.0, //
          0.0, 0.0, 1.0, pv * 0.001, //
          0.0, 0.0, 0.0, 1.0,
        );
    }

    Matrix4 perspective = _pmat(2.0);
    print("Random value: $randFace");
    return Center(
      child: Transform(
        // transform: _transform,
        alignment: FractionalOffset.center,
        transform: perspective.scaled(1.0, 1.0, 1.0)
          // ..rotateX(pi - randFace * pi / 180)
          ..rotateX((randFace - pi) * (pi / 180))
          ..rotateY(0.0)
          ..rotateZ(0.0)
        ,
        child: Image(
        height: 200,
        width: 200,
        image: AssetImage(image(_x + randFace)),
        // fit: BoxFit.contain,
          // alignment: Alignment.bottomLeft,
        ),
      ),
    );
  }
  
 _flipCoinAnimation() {
    print("Touched!");
    if (!_tossController.isAnimating) {
      _tossController.forward(from: 0.0);
    }
  } 

}
