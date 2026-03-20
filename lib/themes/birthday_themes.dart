import 'package:flutter/material.dart';
import 'invitation_theme.dart';

class BirthdayThemes {

  static const cowboy = InvitationTheme(
    primaryColor: Color(0xFF5A3E2B),
    secondaryColor: Color(0xFFD2B48C),
    heroBackground: "assets/templates/birthday/cowboy/bg.jpg",
    fontFamily: "Western",
  );

  static const neon = InvitationTheme(
    primaryColor: Color(0xFFff00ff),
    secondaryColor: Color(0xFF00ffff),
    heroBackground: "assets/templates/birthday/neon/bg.jpg",
    fontFamily: "Neon",
  );

  static const elegant = InvitationTheme(
    primaryColor: Colors.black,
    secondaryColor: Color(0xFFD4AF37),
    heroBackground: "assets/templates/birthday/elegant/bg.jpg",
    fontFamily: "Playfair",
  );

  static const pool = InvitationTheme(
    primaryColor: Color(0xFF00A8E8),
    secondaryColor: Color(0xFFFFFFFF),
    heroBackground: "assets/templates/birthday/pool/bg.jpg",
    fontFamily: "Poppins",
  );

}