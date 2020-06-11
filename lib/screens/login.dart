import 'dart:async';

import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import './register.dart';
import '../utilities/authentication.dart';

const bgColor = const Color(0xFF008CFA);


class LoginPage extends StatelessWidget {
  // StreamController lets other widgets write/read the state of a class, in this case FlipItAuthentication
  final StreamController<FlipItAuthentication> authenticationController;
  LoginPage(this.authenticationController);

  login() async{
    authenticationController.add(FlipItAuthentication.loggedInState());
  }

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
  }

  Widget _registerMessageButton(BuildContext context) {
    return Container(
      // alignment: Alignment.bottomCenter,
      child: FlatButton(
        onPressed: () => {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()))
        },
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          "Don't have an account yet? Register",
          style: cSignUpSignInDecoration,
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Container(        
      alignment: Alignment.centerRight,
      child: Container(
        decoration: cButtonDecoration,
        child: ButtonTheme(
          height: 53.0,
          minWidth: 114.0,
          padding: EdgeInsets.all(8.0),
          splashColor: Colors.grey[350],
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(100.0),
          ),
          child: FlatButton(
            onPressed: () {
              if((usernameController.text == passwordController.text)){
                login();
              } else {
                final snackBar = SnackBar(
                  content: Text('Incorrect Username or Password')
                );

                Scaffold.of(context).showSnackBar(snackBar);
              }
            },
            color: Colors.white,
            child: Text(
              "Login",
              style: cLoginButton,
              )
            ),
          ),
      ),
    );
  }
  
  Widget _usernameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Sign In", style: cTitleStyle,),
        SizedBox(height: 10.0,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: cInputDecoration,
          height: 53.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: InputBorder.none, 
              hintText: 'Username', 
              contentPadding: const EdgeInsets.only(left: 25, right: 30),
              hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w200)
              ),
            controller: usernameController,
          ),
        )
      ],
    );
  }
  
  Widget _passwordInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: cInputDecoration,
          height: 53.0,
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: InputBorder.none, 
              hintText: 'Password',
              hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
              contentPadding: const EdgeInsets.only(left: 25, right: 30),
              ),
            controller: passwordController,
          ),
        )
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    // https://api.flutter.dev/flutter/material/Scaffold/of.html
    return Scaffold(
      body: Builder(
        builder: (BuildContext context){
          return Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: bgColor
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              // physics: AlwaysScrollableScrollPhysics(), // add scroll to view
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Flip It!", style: cFlipItStyle,),
                  SizedBox(height: 88.0,),
                  _usernameInput(),
                  SizedBox(height: 30.0,),
                  _passwordInput(),
                  SizedBox(height: 15.0,),
                  _loginButton(context),
                  // SizedBox(height: 15.0,),
                  // _registerMessageButton()
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment(-2.5, 0.9),
            child: Image(
              height: 307,
              width: 290,
              image: AssetImage('assets/standing-6.png'),
              fit: BoxFit.contain,
              alignment: Alignment.bottomRight,
            ),
          ),
          Container(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _registerMessageButton(context),
            )
          ),
      ],
      );
      }
        )
    );
  }
}