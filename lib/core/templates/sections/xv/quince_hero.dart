import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/scroll_indicator.dart';


class QuinceHero extends StatelessWidget {

  final String title;
  final String heroImage;
  final DateTime eventDate;
  final String eventTime;
  final VoidCallback onPressed;

  const QuinceHero({
    super.key,
    required this.title,
    required this.heroImage,
    required this.eventDate,
    required this.eventTime,
    required this.onPressed,
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
      'Diciembre'
    ];

    return "${date.day} · ${months[date.month]} · ${date.year}";
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,

      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(heroImage),
          fit: BoxFit.cover,
          filterQuality: FilterQuality.low,
        ),
      ),

      child: Container(
        color: Colors.black.withOpacity(0.3),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              "Mis XV Años",
              style: GoogleFonts.playfairDisplay(
                fontSize: 28,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              title,
              style: GoogleFonts.greatVibes(
                fontSize: 60,
                color: const Color(0xFFD4AF37),
              ),
            ),

            const SizedBox(height: 20),

            Column(
              children: [

                Text(
                  _formatDate(eventDate),
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    letterSpacing: 3,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  eventTime,
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    letterSpacing: 2,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 40),

                GestureDetector(
                  onTap: onPressed,
                  child: const ScrollIndicator(),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}