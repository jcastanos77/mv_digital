import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [

        AppleStep(
          number: "01",
          title: "Elige un diseño",
          description:
          "Selecciona una invitación elegante para tu boda o XV años.",
          image:
          "https://images.unsplash.com/photo-1520854221256-17451cc331bf",
        ),

        AppleStep(
          number: "02",
          title: "Personalizamos tu invitación",
          description:
          "Adaptamos la invitación con los detalles de tu evento.",
          image:
          "https://images.unsplash.com/photo-1511795409834-ef04bbd61622",
        ),

        AppleStep(
          number: "03",
          title: "Comparte el enlace",
          description:
          "Envía tu invitación digital a todos tus invitados.",
          image:
          "https://images.unsplash.com/photo-1529333166437-7750a6dd5a70",
        ),

      ],
    );
  }
}

class AppleStep extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final String image;

  const AppleStep({
    super.key,
    required this.number,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 160,
        horizontal: 40,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          /// IMAGEN
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                image,
                height: 500,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 80),

          /// TEXTO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  number,
                  style: const TextStyle(
                    fontSize: 80,
                    color: Colors.white24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  title,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 54,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),

              ],
            ),
          )

        ],
      ),
    );
  }
}