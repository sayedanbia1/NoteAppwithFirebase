import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class appstyle{
   static Color bgcolor =Color(0xFFe2e2fe);
  static Color mincolor=Color(0xFF000633);
  static Color accentcolor=Color(0xFF0065FF);
  static List<Color> cardscolor=[Colors.white,

  Colors.red.shade100,
    Colors.pink.shade100,
    Colors.orange.shade100,
    Colors.yellow.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.blueGrey.shade100,

  ];

  static TextStyle maintitle=
      GoogleFonts.roboto(fontSize: 18,fontWeight: FontWeight.bold);
   static TextStyle maincontent=
   GoogleFonts.nunito(fontSize: 16,fontWeight: FontWeight.normal);

   static TextStyle datatitle=
   GoogleFonts.roboto(fontSize: 13,fontWeight: FontWeight.w500);
}