import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeatureSection extends StatelessWidget {
  const FeatureSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [

        AppleFeature(
          title: "Confirmación de asistencia",
          description:
          "Tus invitados confirman su asistencia directamente desde la invitación.",
          image:
          "assets/cuentaRegresiva.jpeg",
        ),

        AppleFeature(
          title: "Ubicación del evento",
          description:
          "Un mapa integrado para que tus invitados lleguen sin complicaciones.",
          image:
          "assets/ubicacionEvento.jpeg",
        ),

        AppleFeature(
          title: "Cuenta regresiva",
          description:
          "Un contador elegante para que todos esperen el gran día.",
          image:
          "assets/confirmaAsistencia.jpeg",
        ),

      ],
    );
  }
}

class AppleFeature extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const AppleFeature({
    super.key,
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
              height: 280,
              width: double.infinity,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),

          const SizedBox(height: 40),

          _textContent(isMobile),

        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          /// TEXTO
          Expanded(
            child: _textContent(isMobile),
          ),

          const SizedBox(width: 80),

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
          title,
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.playfairDisplay(
            fontSize: isMobile ? 32 : 56,
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