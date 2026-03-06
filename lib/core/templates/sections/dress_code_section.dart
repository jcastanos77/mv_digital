import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DressCodeSection extends StatelessWidget {
  const DressCodeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 30),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 2,
            color: const Color(0xFFC6A23E),
          ),
          const SizedBox(height: 20),

          Text(
            "Código de vestimenta",
            style: GoogleFonts.playfairDisplay(
              fontSize: 28,
              color: const Color(0xFF3A2726),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "Formal elegante\nTonos pastel sugeridos",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              height: 1.6,
              color: const Color(0xFF6E5B55),
            ),
          ),
        ],
      ),
    );
  }
}