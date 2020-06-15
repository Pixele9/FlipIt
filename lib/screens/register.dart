import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:get_ip/get_ip.dart';

import '../utilities/constants.dart';
import '../screens/login.dart';

const bgColor = const Color(0xFF008CFA);

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  String _ip;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }


  Future<void> initPlatformState() async {
    String ipAddress;
    
    try {
      ipAddress = await GetIp.ipAddress;
    } on PlatformException {
      ipAddress = 'Failed to get ipAddress.';
    }

    if (!mounted) return;

    setState(() {
      _ip = ipAddress;
    });
  }

  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Widget _decorImage() {
    return Container(
      alignment: Alignment(-2.6, 0.86),
      child: Image(
        height: 280,
        width: 341,
        image: AssetImage('assets/standing-19.png'),
        fit: BoxFit.contain,
        alignment: Alignment.bottomLeft,
      ),
    );
  }

  Widget _registerMessageButton() {
    return Container(
      child: FlatButton(
        onPressed: () => {
          Navigator.of(context).pop()
        },
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          "Already have an account? Login",
          style: cSignUpSignInDecoration,
        ),
      ),
    );
  }

  Widget _registerButton(BuildContext context) {
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
          if(usernameController.text != '' && passwordController.text != '' && emailController.text != '' && (passwordController.text == confirmController.text)){
                
            String url = 'http://$_ip:8000/signup/';
            Map<String, String> headers = {"Content-type": "application/json"};
            String jsonData = '{"username": "' + usernameController.text + '", "email": "' + emailController.text + '", "password": "' + passwordController.text + '"}';

            Response response = await post(url, headers: headers, body: jsonData);
            int statusCode = response.statusCode;
            print("Response: - $statusCode");
            print("Response: - ${response.body}");

                final snackBar = SnackBar(
                  content: Text('Registration successful!'),
                  action: SnackBarAction(
                    label: 'Go to Login',
                    onPressed: () {
                      Navigator.pop(context);
                    })
                );
                Scaffold.of(context).showSnackBar(snackBar);
              } else {
                final snackBar = SnackBar(
                  content: Text('Something\'s wrong with the data you entered. Please check it and try again.')
                );

                Scaffold.of(context).showSnackBar(snackBar);
              }
            },
            color: Colors.white,
            child: Text(
              "Register",
              style: cLoginButton,
              )
            ),
          ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // prevents messing up w/ elements on screen
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
              alignment: Alignment(-2.6, 0.86),
              child: Image(
                height: 260,
                width: 321,
                image: AssetImage('assets/standing-19.png'),
                fit: BoxFit.contain,
                alignment: Alignment.bottomLeft,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Sign Up", style: cTitleStyle,),
                        SizedBox(height: 10.0,),
                        FormInput('Username', false, usernameController),
                        SizedBox(height: 20.0,),
                        FormInput('Email', false, emailController),
                        SizedBox(height: 20.0,),
                        FormInput('Password', true, passwordController),
                        SizedBox(height: 20.0,),
                        FormInput('Confirm Password', true, confirmController),
                        SizedBox(height: 15.0,),
                        _registerButton(context),
                      ],
                    ),
                    // Container(
                    //   child: Align(
                    //     alignment: Alignment.bottomCenter,
                    //     child: _registerMessageButton(),
                    //   )
                    // ),
                  ],
                ),
              ),
            ),
            // Container(
            //   alignment: Alignment(-2.6, 0.86),
            //   child: Image(
            //     height: 280,
            //     width: 341,
            //     image: AssetImage('assets/standing-19.png'),
            //     fit: BoxFit.contain,
            //     alignment: Alignment.bottomLeft,
            //   ),
            // ),
            Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: _registerMessageButton(),
              )
            ),
          ],
        );
        }
    ),
    );
  }
}

class FormInput extends StatelessWidget {
  final String placeholderName;
  final bool isPassword;
  final TextEditingController controller;

  const FormInput(this.placeholderName, this.isPassword, this.controller);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: cInputDecoration,
      height: 53.0,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        obscureText: isPassword,
        decoration: InputDecoration(
          border: InputBorder.none, 
          hintText: placeholderName,
          contentPadding: const EdgeInsets.only(left: 25, right: 30),
          hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w200)
          ),
        controller: controller,
      ),
    );
  }
}