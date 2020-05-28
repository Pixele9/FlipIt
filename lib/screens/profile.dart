import 'package:flutter/material.dart';

import '../utilities/constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => new _ProfileState();
 }

class _ProfileState extends State<Profile> {
  //DATA
  var white = Colors.white;
  var data = ["Name","Mail","Password"];
  var name = "José Miguel Ángel Nuñéz Pérez";
  var mail = "jose_mike_a.n.p@correo.com";
  var password = "";
  final TextEditingController controller = TextEditingController();
  //Show alert

  void onChanged(String option, String value){
    if (value.isNotEmpty) {
      option=="Name"?setState(() {name = value;}): option == "Mail"? setState(() {mail = value;}):setState(() {password = value;});
      clear();
      confirmation(option);
    }else{
      validation();
    }
    
  }
  void validation(){
    AlertDialog dialog = AlertDialog(
      title: Text("Your input is empty!", style: cfont,),  
      actions: <Widget>[
        FlatButton(
          onPressed: () {Navigator.pop(context);},
          child: Text("OK"),
          ),
      ],
    );
    showDialog(context: context, builder: (BuildContext context) {return dialog; });
  }

  void confirmation(String option){
    AlertDialog dialog = AlertDialog(
      title: Text("Your "+option.toLowerCase()+" has been changed succesfully!", style: cfont,),  
      actions: <Widget>[
        FlatButton(
          onPressed: () {Navigator.pop(context);},
          child: Text("OK"),
          ),
      ],
    );
    showDialog(context: context, builder: (BuildContext context) {return dialog; });
  }
  
  bool obscure(value){
    var secret;
    value=="Password"? secret = true: secret = false;
    return secret;
  }

  void clear(){
    controller.text = "";
    Navigator.pop(context);
  }

  void changeData(String option){
    AlertDialog dialog = AlertDialog(
      title: Text("Change your "+option.toLowerCase(), style: cfont,),  
      content: TextField(controller: controller, obscureText: obscure(option), keyboardType: option=="Mail"? TextInputType.emailAddress: TextInputType.text),
      actions: <Widget>[
        FlatButton(
          onPressed: () {clear();},
          child: Text("Cancel", style: cCancel),
          ),
        FlatButton(
          onPressed: () {onChanged(option,controller.text);},
          child: Text("Accept")
          )
      ],
    );
    showDialog(context: context, builder: (BuildContext context) {return dialog; });
  }
  //Information
  var info = AboutListTile(
    child: Text("App Information", style: cDataStyle,),
    applicationIcon: Icon(Icons.info),
    applicationName: "Flip It!",
    applicationLegalese: "Developers:\nArturo García\nRaúl Gúzman\nÁndres Leal\nDaniel Rincón",
    applicationVersion: "v1.0.0",
    icon: Icon(Icons.info, color: Colors.white,)
  );
  //Every element of the list
  ListTile getItem(Icon icon, String label, String description, int position){
    return ListTile(
      leading: icon,
      title: Text(label, style: cDataStyle,),
      subtitle: Text(description, style: cSubDataStyle,),
      trailing: IconButton(
          icon: Icon(Icons.edit),
          tooltip: 'Edit',
          color: white,
          onPressed: () {changeData(data[position]);},
        ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
      //Scaffold es la base de MaterialDesign de la ruta (pantalla)
      return Scaffold(
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
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              SizedBox(height: 40.0),
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "Flip It!",
                                  style: cFlipItStyle,
                                ),
                                 
                            ),
                            Container(
                              height: 130,
                              width: 110,
                              child: ListView(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: AssetImage('assets/prueba.png'),
                                  radius: 53,
                               ),
                              ],
                              ),
                            ),
                              Container(
                                height: 500,
                                width: MediaQuery.of(context).size.width,
                                child: ListView(
                                  children: <Widget>[
                                    getItem(Icon(Icons.person, color: white, size: 30,), 'Name:', name,0),
                                    getItem(Icon(Icons.mail, color: white, size: 30,), 'Mail:', mail,1),
                                    getItem(Icon(Icons.lock, color: white, size: 30,), 'Password:','*********',2),
                                    info
                                  ],
                                ),
                              ),
                            ]
                        )
                    );
            }),
        )
    );
  }
}



