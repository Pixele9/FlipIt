import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../widgets/flipItInput.dart';
import '../widgets/flipitButton.dart';

class Flip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

     return Scaffold(
          backgroundColor: Color(0xFFFFFFFF),
          appBar: AppBar(),
          body: Align(
            alignment: Alignment.topCenter,
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        alignment: Alignment.center,
                        color: primaryColor,
                        child: Text(
                                  "Flip It!",
                                  style: cTitleViews,
                              ), 
                          );
                  }),
            )
      );
  }
}
