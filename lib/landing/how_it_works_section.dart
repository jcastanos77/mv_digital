import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    const bg = Color(0xFF0F0F0F);
    const champagne = Color(0xFFB08A5B);
    const textSecondary = Color(0xFFB3B3B3);

    return Container(
      color: bg,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 80 : 140,
        horizontal: 24,
      ),
      child: Column(
        children: [

          Text(
            "Cómo funciona",
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 36 : 52,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 40),

          const _Step(
            number: "01",
            title: "Elige un diseño",
            description:
            "Selecciona una invitación elegante para tu boda o XV años.",
          ),

          const _Divider(),

          const _Step(
            number: "02",
            title: "Personalizamos tu invitación",
            description:
            "Adaptamos la invitación con los detalles de tu evento.",
          ),

          const _Divider(),

          const _Step(
            number: "03",
            title: "Comparte el enlace",
            description:
            "Envía tu invitación digital a todos tus invitados.",
          ),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  const _Step({
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    const champagne = Color(0xFFB08A5B);
    const textSecondary = Color(0xFFB3B3B3);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 80),
      child: Column(
        children: [

          Text(
            number,
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 60 : 100,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 28 : 42,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 16),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: isMobile ? 15 : 18,
                height: 1.6,
                color: textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: 60,
      height: 1,
      color: const Color(0xFFB08A5B),
    );
  }
}