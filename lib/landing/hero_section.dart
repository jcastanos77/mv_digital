import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        children: [

          /// IMAGEN DE FONDO
          Positioned.fill(
            child: Image.network(
              "https://images.unsplash.com/photo-1519741497674-611481863552",
              fit: BoxFit.cover,
            ),
          ),

          /// OVERLAY CINEMATOGRAFICO
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
            child: FadeInUp(
              duration: const Duration(milliseconds: 1200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  /// TITULO GIGANTE
                  Text(
                    "Invitaciones\nDigitales",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 92,
                      height: 1.1,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Elegantes. Modernas. Memorables.",
                    style: TextStyle(
                      fontSize: 24,
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