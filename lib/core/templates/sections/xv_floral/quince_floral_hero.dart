import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/scroll_indicator.dart';

class QuinceFloralHero extends StatelessWidget {
  final String title;
  final DateTime eventDate;
  final String eventTime;

  const QuinceFloralHero({
    super.key,
    required this.title,
    required this.eventDate,
    required this.eventTime,
  });

  String _formatDate(DateTime date) {
    const months = [
      '',
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre',
    ];

    return '${date.day} DE ${months[date.month].toUpperCase()} DE ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      constraints: const BoxConstraints(
        minHeight: 650,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/floral_hero.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  'SAVE THE DATE',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 5,
                    color: const Color(0xFFC49A45),
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  'MIS XV AÑOS',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: screenWidth > 600 ? 30 : 23,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 6,
                    color: const Color(0xFF2E2A2A),
                  ),
                ),

                const SizedBox(height: 24),

                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.greatVibes(
                      fontSize: screenWidth > 600 ? 100 : 76,
                      height: 1.1,
                      color: const Color(0xFFC49A45),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Container(
                  width: 65,
                  height: 1,
                  color: const Color(0xFFC49A45),
                ),

                const SizedBox(height: 20),

                Text(
                  _formatDate(eventDate),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: screenWidth > 600 ? 13 : 10,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 3,
                    color: const Color(0xFF3B3535),
                  ),
                ),

                if (eventTime.isNotEmpty) ...[
                  const SizedBox(height: 12),

                  Text(
                    eventTime,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      letterSpacing: 2,
                      color: const Color(0xFF3B3535),
                    ),
                  ),
                ],

                const SizedBox(height: 60),

                const ScrollIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}