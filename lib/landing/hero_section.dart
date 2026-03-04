import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = MediaQuery.of(context).size.width < 800;

    return SizedBox(
      height: screenHeight,
      width: double.infinity,
      child: Stack(
        children: [

          /// IMAGEN DE FONDO
          Positioned.fill(
            child: Image.asset(
              "assets/principal.jpg",
              fit: BoxFit.cover,
              filterQuality: FilterQuality.low,
            ),
          ),

          /// OVERLAY
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(.6),
                    Colors.black.withOpacity(.2),
                    Colors.black.withOpacity(.7),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          /// CONTENIDO
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  /// TITULO
                  Text(
                    "Invitaciones\nDigitales",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: isMobile ? 48 : 92,
                      height: 1.1,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "Elegantes. Modernas. Memorables.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 24,
                      color: Colors.white70,
                    ),
                  ),

                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}