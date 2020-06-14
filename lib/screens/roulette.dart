import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import '../utilities/board_view.dart';
import '../utilities/items.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

class RoulettePage extends StatefulWidget {
  final List<Item> _items;
  final String code;
  RoulettePage(this._items, this.code);  

  @override
  State<StatefulWidget> createState() {
    return _RoulettePageState(_items, code);
  }
}

class _RoulettePageState extends State<RoulettePage> with SingleTickerProviderStateMixin {
  _RoulettePageState(this._items, this.code);  
  // final TextEditingController optionController = new TextEditingController();
  // final GlobalKey<FormState> _keyDialogForm = new GlobalKey<FormState>();
  final String code;
  WebSocketChannel channel;
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

    _ctrl.addStatusListener(_checkEnded);

    _ani = CurvedAnimation(parent: _ctrl, curve: Curves.fastLinearToSlowEaseIn);
    channel = IOWebSocketChannel.connect('ws://192.168.0.5:8000/game/$code');
    _sendMessage(text:'{"text": "Connected", "source": "host", "type": "connection"}');
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
                        stream: this.channel.stream,
                        builder: (context, snapshot) {

                          // Snapshot processing
                          Map<String, dynamic> data = jsonDecode(snapshot.data);
                          data = data['message'];
                          String text = data['text']; 
                          String source = data['source']; 
                          String type = data['type'];

                          if (type != "connection" && source != "host"){
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 80,
                                  width: 140,
                                  child: Text(
                                    snapshot.hasData ? '$text' : '',
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
                          } else {
                            return Container(height: 0, width: 0,);
                          }

                        },
                      )
                    ],
                  );
                }),
          ),
    );
  }

  void _sendMessage({text=''}) {
    if (text != '') {
      channel.sink.add('{"message": $text}');
    }
  }

  @override
  void dispose() {
    channel.sink.close();
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
        onTap: _caller,
      ),
    );
  }

  _caller() {
    _animation();
    _sendMessage(text:'{"text": "Spinning...", "source": "host", "type": "start"}');
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

  void _checkEnded(AnimationStatus status) {
    if (status.index == 3) {
      var _index = _calIndex(_ctrl.value * _angle + _current);
      String _text = _items[_index].text;

      _sendMessage(text:'{"text": "$_text", "source": "host", "type": "end"}'); 
    }
  }
}