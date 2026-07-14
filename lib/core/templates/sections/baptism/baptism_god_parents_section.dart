import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BaptismGodParentsSection extends StatelessWidget {
  const BaptismGodParentsSection({
    super.key,
    required this.godParents,
  });

  final List<String> godParents;

  @override
  Widget build(BuildContext context) {
    if (godParents.isEmpty) {
      return const SizedBox.shrink();
    }

    const gold = Color(0xFFB08D57);
    const text = Color(0xFF444444);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const Icon(
            Icons.favorite_border_rounded,
            color: gold,
            size: 34,
          ),

          const SizedBox(height: 20),

          Text(
            "CON AMOR",
            style: GoogleFonts.montserrat(
              fontSize: 14,
              letterSpacing: 4,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 22),

          Text(
            "Mis Padrinos",
            style: GoogleFonts.cormorantGaramond(
              fontSize: 44,
              fontWeight: FontWeight.w600,
              color: gold,
            ),
          ),

          const SizedBox(height: 30),

          ...List.generate(godParents.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Text(
                godParents[index],
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: text,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}