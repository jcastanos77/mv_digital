import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeatureSection extends StatelessWidget {
  const FeatureSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    const bg = Color(0xFF0F0F0F);
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
            "Todo lo que necesitas",
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 34 : 48,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 60),

          Wrap(
            spacing: 40,
            runSpacing: 50,
            alignment: WrapAlignment.center,
            children: const [

              _FeatureItem(
                title: "Confirmación de asistencia",
                description: "Tus invitados confirman fácilmente.",
              ),

              _FeatureItem(
                title: "Ubicación del evento",
                description: "Mapa integrado para llegar sin complicaciones.",
              ),

              _FeatureItem(
                title: "Cuenta regresiva",
                description: "Cuenta regresiva elegante en tiempo real.",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String title;
  final String description;

  const _FeatureItem({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    const champagne = Color(0xFFB08A5B);
    const textSecondary = Color(0xFFB3B3B3);

    return SizedBox(
      width: 260,
      child: Column(
        children: [

          /// PUNTO MÁS PREMIUM
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: champagne,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: champagne.withOpacity(0.4),
                  blurRadius: 8,
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              height: 1.6,
              color: textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}