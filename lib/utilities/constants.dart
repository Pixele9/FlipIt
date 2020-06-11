import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

const primaryColor = const Color(0xFF008CFA);
const secondaryColor = const Color(0xFF006DC3);
const blackColor = const Color(0xFF414141);

final cLoginButton = GoogleFonts.montserrat( // Text Style
  fontWeight: FontWeight.w300,
  fontSize: 18.0,
);

final cFlipItStyle = GoogleFonts.montserrat(
  color: Colors.white,
  fontWeight: FontWeight.w900,
  fontSize: 55,
);

final cTitleStyle = GoogleFonts.montserrat(
  color: Colors.white,
  fontWeight: FontWeight.w500,
  fontSize: 30,
);

final cLabelStyle = GoogleFonts.montserrat(
  color: Colors.white,
  fontWeight: FontWeight.w200,
  fontSize: 30,
);

final cInputDecoration = BoxDecoration(
  color: Color(0xFFFFFFFF),
  borderRadius: BorderRadius.circular(100.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final cOptionInputDecoration = BoxDecoration(
  color: Color(0xFFFFFFFF),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final cButtonDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(100.0),
  boxShadow: [
    BoxShadow(
      color: secondaryColor,
      blurRadius: 0.0,
      offset: Offset(0, 8),
    ),
  ],
);

final cMenuButtonDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(15.0),
  boxShadow: [
    BoxShadow(
      color: secondaryColor,
      blurRadius: 0.0,
      offset: Offset(0, 11),
    ),
  ],
);

final cMenuButtontext = GoogleFonts.montserrat( // Text Style
  color: Colors.black,
  fontWeight: FontWeight.w900,
  fontSize: 35,
);

final cSignUpSignInDecoration = GoogleFonts.montserrat(
  color: Colors.white,
  fontWeight: FontWeight.w300,
  fontSize: 12,
);

final cMenuButtonsText = GoogleFonts.montserrat(
  color: blackColor,
  fontWeight: FontWeight.w900,
  fontSize: 34.0,
);

final cTitleViews = GoogleFonts.montserrat(
  color: Colors.white,
  fontWeight: FontWeight.w900,
  fontSize: 45,
);

final cDataStyle = GoogleFonts.montserrat(
  color: Colors.white,
  fontWeight: FontWeight.w600,
  fontSize: 25.0,
);

final cSubDataStyle = GoogleFonts.montserrat(
  color: Colors.white,
  fontWeight: FontWeight.w300,
  fontSize: 18.0,
);

final cCancel = GoogleFonts.montserrat(
  color: Colors.redAccent,
);

final cfont = GoogleFonts.montserrat(
);

Random random = new Random();