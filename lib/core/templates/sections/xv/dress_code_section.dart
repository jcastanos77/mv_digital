import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DressCodeSection extends StatelessWidget {
  final String dressCode;
  final bool princessTheme;

  const DressCodeSection({
    super.key,
    required this.dressCode,
    this.princessTheme = false,
  });

  @override
  Widget build(BuildContext context) {
    return princessTheme
        ? _buildPrincessTheme()
        : _buildDefaultTheme();
  }

  // ========================================
  // DISEÑO ORIGINAL
  // ========================================

  Widget _buildDefaultTheme() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(
        vertical: 70,
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
          Container(
            width: 40,
            height: 2,
            color: const Color(0xFFC6A23E),
          ),

          const SizedBox(height: 20),

          Text(
            'Código de vestimenta',
            textAlign: TextAlign.center,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 38,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFB08D57),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            dressCode,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 20,
              height: 1.6,
              color: const Color(0xFF6E5B55),
            ),
          ),
        ],
      ),
    );
  }

  // ========================================
  // TEMA PRINCESA
  // ========================================

  Widget _buildPrincessTheme() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(
        vertical: 60,
        horizontal: 30,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF6F7),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(
          color: const Color(0xFFD9A0AA).withOpacity(.55),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9D5865).withOpacity(.10),
            blurRadius: 25,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          // Detalle superior
          const Text(
            '♛',
            style: TextStyle(
              fontSize: 38,
              color: Color(0xFFC69A4A),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'CÓDIGO DE VESTIMENTA',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              letterSpacing: 3,
              color: const Color(0xFFC69A4A),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            'Para esta ocasión especial',
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF9D5865),
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            '✦  🦋  ✦',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFC69A4A),
            ),
          ),

          const SizedBox(height: 35),

          // Icono principal
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFF3DDE0),
              border: Border.all(
                color: const Color(0xFFC69A4A).withOpacity(.5),
              ),
            ),
            child: const Icon(
              Icons.checkroom_outlined,
              size: 34,
              color: Color(0xFF9D5865),
            ),
          ),

          const SizedBox(height: 25),

          Text(
            dressCode,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 18,
              height: 1.7,
              color: const Color(0xFF754B54),
            ),
          ),
        ],
      ),
    );
  }
}