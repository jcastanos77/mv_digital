import 'dart:ui';

import 'package:flutter/material.dart';

import 'cta_section.dart';
import 'demo_section.dart';
import 'feature_section.dart';
import 'hero_section.dart';
import 'how_it_works_section.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  final ScrollController controller = ScrollController();

  bool scrolled = false;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      if (controller.offset > 40 && !scrolled) {
        setState(() => scrolled = true);
      }

      if (controller.offset <= 40 && scrolled) {
        setState(() => scrolled = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// CONTENIDO
          SingleChildScrollView(
            controller: controller,
            child: Column(
              children: const [

                HeroSection(),
                DemoSection(),
                FeatureSection(),
                HowItWorksSection(),
                FooterSection(),

              ],
            ),
          ),

          /// NAVBAR
          Navbar(scrolled: scrolled)

        ],
      ),
    );
  }
}

class Navbar extends StatelessWidget {
  final bool scrolled;

  const Navbar({super.key, required this.scrolled});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: scrolled ? 12 : 0,
            sigmaY: scrolled ? 12 : 0,
          ),
          child: Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: scrolled
                  ? Colors.black.withOpacity(.25)
                  : Colors.transparent,
              border: Border(
                bottom: BorderSide(
                  color: scrolled
                      ? Colors.white.withOpacity(.08)
                      : Colors.transparent,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                /// LOGO
                Row(
                  children: [

                    Image.asset(
                      "assets/logo_mv_digital.png",
                      height: 40,
                      width: 40,
                    ),

                    const SizedBox(width: 12),

                    const Text(
                      "MV Digital",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: .3,
                      ),
                    )

                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final String text;

  const NavItem(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.white70,
        ),
      ),
    );
  }
}