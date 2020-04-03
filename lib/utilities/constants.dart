import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryColor = const Color(0xFF008CFA);
const secondaryColor = const Color(0xFF006DC3);

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
      color: Colors.black38,
      blurRadius: 0.0,
      offset: Offset(0, 8),
    ),
  ],
);

final cSignUpSignInDecoration = GoogleFonts.montserrat(
  color: Colors.white,
  fontWeight: FontWeight.w300,
  fontSize: 12,
);