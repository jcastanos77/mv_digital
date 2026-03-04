import 'package:cached_network_image/cached_network_image.dart';
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
          "assets/elige.jpeg",
        ),

        AppleStep(
          number: "02",
          title: "Personalizamos tu invitación",
          description:
          "Adaptamos la invitación con los detalles de tu evento.",
          image:
          "assets/personaliza.jpeg",
        ),

        AppleStep(
          number: "03",
          title: "Comparte el enlace",
          description:
          "Envía tu invitación digital a todos tus invitados.",
          image:
          "assets/comparte.jpeg",
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

    bool isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 80 : 160,
        horizontal: isMobile ? 20 : 40,
      ),
      child: isMobile
          ? Column(
        children: [

          /// IMAGEN
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              image,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.low,
            ),
          ),

          const SizedBox(height: 40),

          _textContent(isMobile),

        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          /// IMAGEN
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: CachedNetworkImage(
                imageUrl: image,
                height: 500,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 80),

          /// TEXTO
          Expanded(
            child: _textContent(isMobile),
          ),

        ],
      ),
    );
  }

  Widget _textContent(bool isMobile) {
    return Column(
      crossAxisAlignment:
      isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [

        Text(
          number,
          style: TextStyle(
            fontSize: isMobile ? 50 : 80,
            color: Colors.white24,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          title,
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.playfairDisplay(
            fontSize: isMobile ? 32 : 54,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          description,
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            fontSize: isMobile ? 16 : 20,
            color: Colors.white70,
          ),
        ),

      ],
    );
  }
}