import 'package:flutter/cupertino.dart';
import 'dart:async';
import '../screens/login.dart';
import '../screens/menu.dart';

class FlipItAuthentication{
  final bool authenticated;

  // Changes the authentication state to false
  FlipItAuthentication.initialState({this.authenticated = false});

  // Changes the authentication state to true
  FlipItAuthentication.loggedInState({this.authenticated = true});
}

// This is the widget that is loaded when the app starts
class AuthenticationWidget extends StatelessWidget{
  // Creates a StreamController that lets other widgets write/read the state of a class, in this case FlipItAuthentication
  final StreamController<FlipItAuthentication> authenticationController = new StreamController<FlipItAuthentication>();

  // This Widget returns the appropiate widget deppending on whether the user is authenticated or not
  Widget buildUi(BuildContext context, FlipItAuthentication state) {
    if (state.authenticated) {
      return Menu(authenticationController);
    } else {
      return LoginPage(authenticationController);
    }
  }

// This widget implementes a StreamBuilder, StreamBuilder allows a widget to rebuild itself everytime the stream it's listening to changes
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<FlipItAuthentication>(
        stream: authenticationController.stream,
        initialData: new FlipItAuthentication.initialState(),
        builder: (BuildContext context, AsyncSnapshot<FlipItAuthentication> snapshot) {
          final state = snapshot.data;
          return buildUi(context, state);
        });
  }
}