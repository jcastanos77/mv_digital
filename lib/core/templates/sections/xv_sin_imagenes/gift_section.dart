import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GiftSection extends StatelessWidget {
  const GiftSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(
        vertical: 60,
        horizontal: 30,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "🎁",
            style: TextStyle(
              fontSize: 42,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "Regalos",
            textAlign: TextAlign.center,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 42,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFB76E79),
            ),
          ),

          const SizedBox(height: 20),

          Container(
            width: 40,
            height: 2,
            color: const Color(0xFFE6B7C1),
          ),

          const SizedBox(height: 30),

          Text(
            "Tu presencia es el mejor regalo,",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: const Color(0xFF6E5B55),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "pero si deseas tener un detalle conmigo,",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 15,
              color: const Color(0xFF6E5B55),
            ),
          ),

          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 28,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFCEEF1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.payments_outlined,
                  size: 32,
                  color: Color(0xFFB76E79),
                ),

                const SizedBox(height: 12),

                Text(
                  "Regalo en efectivo",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 20,
                    color: const Color(0xFFB76E79),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          Text(
            "¡Gracias por formar parte de este día tan especial! ✨",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: const Color(0xFF8C7B75),
            ),
          ),
        ],
      ),
    );
  }
}