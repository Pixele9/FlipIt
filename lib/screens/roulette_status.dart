import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'dart:convert';

class RouletteStatus extends StatefulWidget {
  
  final String code;
  RouletteStatus(this.code);

  @override
  _RouletteStatusState createState() {
    return _RouletteStatusState(code);
  }
}

class _RouletteStatusState extends State<RouletteStatus> {

  _RouletteStatusState(this.code);
  String code;
  WebSocketChannel channel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    channel = IOWebSocketChannel.connect('ws://192.168.0.5:8000/game/$code');
    _sendMessage(text:'{"text": "Connected", "source": "client", "type": "connection"}');
  }
  //DATA

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text("Status")),
          backgroundColor: primaryColor,
          //Body representa el body de la ruta
          body: Align(
          //Esta propiedad de la widget Align alinea todo el contenido en la parte superior y al centro 
            alignment: Alignment.topCenter,
            //Lo importante de la widget LayoutBuilder es que esta widget se adapta al tamaño de la widget padre
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        color: primaryColor,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Roulette Status",
                                style: cStatusTitleStyle,
                              ),
                              SizedBox(height: 10.0,),
                              StreamBuilder(
                                stream: this.channel.stream,
                                builder: (context, snapshot) {
                                  Map<String, dynamic> data = jsonDecode(snapshot.data);
                                  data = data['message'];
                                  String text = data['text']; 
                                  String source = data['source']; 
                                  String type = data['type'];

                                  if (type != "connection" && source != "client"){

                                    if (type == "start"){
                                      return Text(
                                        "Spinning...",
                                        style: cStatusStyle,
                                      );
                                    } else if (type == 'end') {
                                      return Column(
                                        children: <Widget>[
                                          Text(
                                            "The winner is:",
                                            style: cStatusStyle,
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            "$text!",
                                            style: cResultStyle,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      );
                                    }
                                  }
                                  return Text(
                                    "Loading...",
                                    style: cStatusStyle,
                                  );
                                }
                              ),
                            ]
                          ) 
                        )
                    );
            }), 
        )
    );
  }

  void _sendMessage({text=''}) {
    if (text != '') {
      channel.sink.add('{"message": $text}');
    }
  }
}


