import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuinceFloralDressCode extends StatelessWidget {
  final String dressCode;

  const QuinceFloralDressCode({
    super.key,
    required this.dressCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFFFCF8),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 70,
      ),
      child: Column(
        children: [
          /// ICONO SUPERIOR
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFFFAF0),
              border: Border.all(
                color: const Color(0xFFDCC48D),
              ),
            ),
            child: const Icon(
              Icons.checkroom_outlined,
              size: 30,
              color: Color(0xFFC49A45),
            ),
          ),

          const SizedBox(height: 28),

          Text(
            'CÓDIGO DE VESTIMENTA',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 3.5,
              color: const Color(0xFFC49A45),
            ),
          ),

          const SizedBox(height: 14),

          Text(
            'Para esta ocasión especial',
            textAlign: TextAlign.center,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3B3530),
            ),
          ),

          const SizedBox(height: 20),

          const _FloralOrnament(),

          const SizedBox(height: 38),

          /// CÓDIGO
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 420),
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 28,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFFE7D7B0),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFB89B65).withOpacity(.08),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Text(
              dressCode,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 17,
                height: 1.7,
                color: const Color(0xFF625951),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FloralOrnament extends StatelessWidget {
  const _FloralOrnament();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 55,
          height: 1,
          color: const Color(0xFFD1B16E),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Icon(
            Icons.local_florist_outlined,
            size: 18,
            color: Color(0xFFC49A45),
          ),
        ),

        Container(
          width: 55,
          height: 1,
          color: const Color(0xFFD1B16E),
        ),
      ],
    );
  }
}