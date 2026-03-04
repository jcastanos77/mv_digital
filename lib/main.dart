import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mv_digital/core/templates/quince_glam.dart';

import 'core/templates/wedding_glam.dart';
import 'landing/landing_mv_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invitaciones Digitales',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LandingPage(),
    );
  }
}