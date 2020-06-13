import 'dart:ui';
import 'package:flutter/material.dart';
import '../utilities/board_view.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../utilities/items.dart';
import 'dart:math';

class RoulettePage extends StatefulWidget {
  final List<Item> _items;
  final WebSocketChannel channel;
  RoulettePage(this._items, {this.channel});  

  @override
  State<StatefulWidget> createState() {
    return _RoulettePageState(_items, channel);
  }
}

class _RoulettePageState extends State<RoulettePage> with SingleTickerProviderStateMixin {
  _RoulettePageState(this._items, this.channel);  
  // final TextEditingController optionController = new TextEditingController();
  // final GlobalKey<FormState> _keyDialogForm = new GlobalKey<FormState>();
  final WebSocketChannel channel;
  double _angle = 0;
  double _current = 0;
  AnimationController _ctrl;
  Animation _ani;
  final List<Item> _items;

  @override
  void initState() {
    super.initState();
    var _duration = Duration(milliseconds: 5000);
    _ctrl = AnimationController(vsync: this, duration: _duration);
    _ani = CurvedAnimation(parent: _ctrl, curve: Curves.fastLinearToSlowEaseIn);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
          backgroundColor: Color(0xFFFFFFFF),
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
                      StreamBuilder(
                        stream: widget.channel.stream,
                        builder: (context, snapshot) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 80,
                                width: 140,
                                child: Text(
                                  snapshot.hasData ? '${snapshot.data}' : '',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  );
                }),
          ),
    );
  }

  void _sendMessage({text=''}) {
    print(widget.channel.sink);
    if (text != '') {
      widget.channel.sink.add('{"message": "$text"}');
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }

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
              color: Colors.black,
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