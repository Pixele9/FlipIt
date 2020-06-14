import 'package:shared_preferences/shared_preferences.dart';
import '../utilities/authentication.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../utilities/ensurevisible.dart';
import 'package:http/http.dart';
import './register.dart';
import 'dart:async';
import 'dart:convert';

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

  FocusNode focusNodeUsername = new FocusNode();
  FocusNode focusNodePassword = new FocusNode();

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
            onPressed: () async {
              if(usernameController.text != '' && passwordController.text  != ''){
                print("username: - ${usernameController.text}");
                print("password: - ${passwordController.text}");

                String url = 'http://192.168.1.86:8000/login/';
                Map<String, String> headers = {"Content-type": "application/json"};
                String jsonData = '{"username": "' + usernameController.text + '", "password": "' + passwordController.text + '"}';

                Response response = await post(url, headers: headers, body: jsonData);
                int statusCode = response.statusCode;
                
                var data = json.decode(response.body);
                final prefs = await SharedPreferences.getInstance();

                prefs.setString('id', data['user'].toString());
                prefs.setString('username', data['username']);
                prefs.setString('email', data['email']);

                if (statusCode == 200){
                  login();
                } else {
                  final snackBar = SnackBar(
                    content: Text('Incorrect Username or Password')
                  );

                  Scaffold.of(context).showSnackBar(snackBar);
                } 
              } else {
                final snackBar = SnackBar(
                  content: Text('Complete the fields, please')
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
          child: EnsureVisibleWhenFocused(
            child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: InputBorder.none, 
              hintText: 'Username', 
              contentPadding: const EdgeInsets.only(left: 25, right: 30),
              hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w200)
              ),
            controller: usernameController,
          ), focusNode: focusNodeUsername)
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
          child: EnsureVisibleWhenFocused(
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
            focusNode: focusNodePassword)
        )
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    // https://api.flutter.dev/flutter/material/Scaffold/of.html
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
            alignment: Alignment(-1.7, 0.9),
            child: Image(
              height: 250,
              width: 250,
              image: AssetImage('assets/standing-6.png'),
              fit: BoxFit.contain,
              alignment: Alignment.bottomRight,
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
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
          // Container(
          //   alignment: Alignment(-1.7, 0.9),
          //   child: Image(
          //     height: 250,
          //     width: 250,
          //     image: AssetImage('assets/standing-6.png'),
          //     fit: BoxFit.contain,
          //     alignment: Alignment.bottomRight,
          //   ),
          // ),
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