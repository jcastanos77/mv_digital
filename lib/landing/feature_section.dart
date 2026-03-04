import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeatureSection extends StatelessWidget {
  const FeatureSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [

        AppleFeature(
          title: "Confirmación de asistencia",
          description:
          "Tus invitados confirman su asistencia directamente desde la invitación.",
          image:
          "https://images.unsplash.com/photo-1521737604893-d14cc237f11d",
        ),

        AppleFeature(
          title: "Ubicación del evento",
          description:
          "Un mapa integrado para que tus invitados lleguen sin complicaciones.",
          image:
          "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
        ),

        AppleFeature(
          title: "Cuenta regresiva",
          description:
          "Un contador elegante para que todos esperen el gran día.",
          image:
          "https://images.unsplash.com/photo-1492684223066-81342ee5ff30",
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
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 160,
        horizontal: 40,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          /// TEXTO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 56,
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
          ),

          const SizedBox(width: 80),

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
          )

        ],
      ),
    );
  }
}