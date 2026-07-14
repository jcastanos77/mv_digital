import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BaptismVerseSection extends StatelessWidget {
  final String verse;

  const BaptismVerseSection({
    super.key,
    required this.verse,
  });

  @override
  Widget build(BuildContext context) {
    if (verse.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    const gold = Color(0xFFB08D57);
    const background = Color(0xFFF8F5F1);
    const text = Color(0xFF4A4A4A);

    return Container(
      width: double.infinity,
      color: background,
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 40,
      ),
      child: Column(
        children: [

          const Icon(
            Icons.auto_awesome,
            color: gold,
            size: 32,
          ),

          const SizedBox(height: 18),

          Text(
            "PALABRA DE DIOS",
            style: GoogleFonts.montserrat(
              fontSize: 14,
              letterSpacing: 4,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 28),

          Text(
            "❝",
            style: GoogleFonts.cormorantGaramond(
              fontSize: 58,
              color: gold,
              height: .8,
            ),
          ),

          Text(
            verse,
            textAlign: TextAlign.center,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 30,
              height: 1.5,
              color: text,
              fontStyle: FontStyle.italic,
            ),
          ),

          const SizedBox(height: 22),

          Container(
            width: 70,
            height: 1,
            color: gold,
          ),
        ],
      ),
    );
  }
}