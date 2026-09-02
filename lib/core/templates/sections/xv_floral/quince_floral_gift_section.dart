import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuinceFloralGiftSection extends StatelessWidget {
  final String title;
  final String description;

  const QuinceFloralGiftSection({
    super.key,
    required this.title,
    required this.description,
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
          /// ICONO
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFFFAF0),
              border: Border.all(
                color: const Color(0xFFDCC48D),
              ),
            ),
            child: const Icon(
              Icons.card_giftcard_outlined,
              size: 34,
              color: Color(0xFFC49A45),
            ),
          ),

          const SizedBox(height: 28),

          Text(
            'REGALOS',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 4,
              color: const Color(0xFFC49A45),
            ),
          ),

          const SizedBox(height: 14),

          Text(
            'Un detalle para recordar',
            textAlign: TextAlign.center,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3B3530),
            ),
          ),

          const SizedBox(height: 20),

          const _GiftOrnament(),

          const SizedBox(height: 38),

          Text(
            'Tu presencia es el mejor regalo, pero si deseas tener un detalle conmigo, agradeceré mucho tu cariño.',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 15,
              height: 1.7,
              color: const Color(0xFF625951),
            ),
          ),

          const SizedBox(height: 32),

          /// TARJETA DEL REGALO
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              maxWidth: 420,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 26,
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
            child: Column(
              children: [
                const Icon(
                  Icons.favorite_border,
                  size: 28,
                  color: Color(0xFFC49A45),
                ),

                const SizedBox(height: 14),

                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF3B3530),
                  ),
                ),

                if (description.isNotEmpty) ...[
                  const SizedBox(height: 12),

                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      height: 1.6,
                      color: const Color(0xFF625951),
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 30),

          Text(
            'Gracias por formar parte de este día tan especial.',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: const Color(0xFF8A8178),
            ),
          ),
        ],
      ),
    );
  }
}

class _GiftOrnament extends StatelessWidget {
  const _GiftOrnament();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
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
          width: 50,
          height: 1,
          color: const Color(0xFFD1B16E),
        ),
      ],
    );
  }
}