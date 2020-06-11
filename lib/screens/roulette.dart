import 'dart:ui';
import 'package:flutter/material.dart';
import '../utilities/board_view.dart';
import '../utilities/constants.dart';
import '../utilities/items.dart';
import 'dart:math';

class RoulettePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RoulettePageState();
  }
}

class _RoulettePageState extends State<RoulettePage> with SingleTickerProviderStateMixin {

  // final TextEditingController optionController = new TextEditingController();
  // final GlobalKey<FormState> _keyDialogForm = new GlobalKey<FormState>();
  double _angle = 0;
  double _current = 0;
  AnimationController _ctrl;
  Animation _ani;
  List<Item> _items = [
    Item(" ", Colors.accents[0]),
  ];

  @override
  void initState() {
    super.initState();
    // optionController.text = "";
    var _duration = Duration(milliseconds: 5000);
    _ctrl = AnimationController(vsync: this, duration: _duration);
    _ani = CurvedAnimation(parent: _ctrl, curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(),
          body: Container(
            child: AnimatedBuilder(
                animation: _ani,
                builder: (context, child) {
                  final _value = _ani.value;
                  final _angle = _value * this._angle;
                  return Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      BoardView(items: _items, current: _current, angle: _angle),
                      _buildGo(),
                      _buildResult(_value),
                      // FlatButton(
                      //   onPressed: showOptionDialog(), 
                      //   child: null
                      // )
                    ],
                  );
                }),
          ),
    );
  }

  // showOptionDialog() {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Form(
  //             key: _keyDialogForm,
  //             child: Column(
  //               children: <Widget>[
  //                 TextFormField(
  //                   decoration: const InputDecoration(
  //                     icon: Icon(Icons.ac_unit),
  //                   ),
  //                   maxLength: 8,
  //                   textAlign: TextAlign.center,
  //                   onSaved: (val) {
  //                     optionController.text = val;
  //                     setState(() {});
  //                   },
  //                   autovalidate: true,
  //                   validator: (value) {
  //                     if (value.isEmpty) {
  //                       return 'Enter the new option';
  //                     }

  //                     return null;
  //                   },
  //                 )
  //               ],
  //             ),
  //           ),
  //           actions: <Widget>[
  //             FlatButton(
  //               onPressed: () {
  //                 if (_keyDialogForm.currentState.validate()) {
  //                   _keyDialogForm.currentState.save();

  //                   Navigator.pop(context);
  //                 }
  //               },
  //               child: Text('Save'),
  //               color: Colors.blue,
  //             ),
  //             FlatButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text('Cancel')),
  //           ],
  //         );
  //       });
  // }


  _buildGo() {
    return Material(
      color: Colors.white,
      shape: CircleBorder(),
      child: InkWell(
        customBorder: CircleBorder(),
        child: Container(
          alignment: Alignment.center,
          height: 72,
          width: 72,
          child: Text(
            "Start",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        onTap: _animation,
      ),
    );
  }

  _animation() {
    if (!_ctrl.isAnimating) {
      var _random = Random().nextDouble();
      _angle = 20 + Random().nextInt(5) + _random;
      _ctrl.forward(from: 0.0).then((_) {
        _current = (_current + _random);
        _current = _current - _current ~/ 1;
        _ctrl.reset();
      });
    }
  }

  int _calIndex(value) {
    var _base = (2 * pi / _items.length / 2) / (2 * pi);
    return (((_base + value) % 1) * _items.length).floor();
  }

  _buildResult(_value) {
    var _index = _calIndex(_value * _angle + _current);
    String _text = _items[_index].text;
    _text = _text[0].toUpperCase() + _text.substring(1);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 120,
          width: 140,
          child: Text(
            _text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
            textAlign: TextAlign.center,
          )
        ),
      ),
    );
  }
}