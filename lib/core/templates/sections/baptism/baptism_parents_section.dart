import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BaptismParentsSection extends StatelessWidget {
  const BaptismParentsSection({
    super.key,
    required this.father,
    required this.mother,
  });

  final String father;
  final String mother;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const Icon(
            Icons.favorite_outline,
            color: Color(0xFFD4AF37),
            size: 34,
          ),

          const SizedBox(height: 18),

          const Text(
            "CON LA BENDICIÓN DE DIOS",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              letterSpacing: 3,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 25),

          Text(
            "Mis Papás",
            style: GoogleFonts.cormorantGaramond(
              fontSize: 42,
              fontWeight: FontWeight.w600,
              color: const Color(0xffB08D57),
            ),
          ),

          const SizedBox(height: 30),

          Text(
            father,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3E3E3E),
            ),
          ),

          const SizedBox(height: 4),

          Container(
            width: 35,
            height: 1,
            color: const Color(0xFFB08D57),
          ),

          const SizedBox(height: 8),

          Text(
            "&",
            style: GoogleFonts.cormorantGaramond(
              fontSize: 22,
              color: const Color(0xFFB08D57),
            ),
          ),

          const SizedBox(height: 8),

          Container(
            width: 35,
            height: 1,
            color: const Color(0xFFB08D57),
          ),

          const SizedBox(height: 4),

          Text(
            mother,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3E3E3E),
            ),
          ),
        ],
      ),
    );
  }
}