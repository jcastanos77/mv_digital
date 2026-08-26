import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/scroll_indicator.dart';

class QuincePrincessHero extends StatelessWidget {
  final String title;
  final DateTime eventDate;
  final String eventTime;

  const QuincePrincessHero({
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

    return '${date.day} · ${months[date.month]} · ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF8ECEE),
            Color(0xFFE8BFC5),
            Color(0xFFD9A0AA),
          ],
        ),
      ),
      child: Stack(
        children: [
          // ==============================
          // DECORACIÓN DE FONDO
          // ==============================

          Positioned(
            top: -80,
            left: -80,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.18),
              ),
            ),
          ),

          Positioned(
            top: 100,
            right: -100,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.12),
              ),
            ),
          ),

          Positioned(
            bottom: -120,
            left: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFB76E79).withOpacity(0.10),
              ),
            ),
          ),

          // ==============================
          // MARIPOSAS
          // ==============================

          const Positioned(
            top: 130,
            left: 30,
            child: _Butterfly(
              size: 34,
              rotation: -0.3,
            ),
          ),

          const Positioned(
            top: 190,
            right: 35,
            child: _Butterfly(
              size: 26,
              rotation: 0.4,
            ),
          ),

          const Positioned(
            top: 350,
            left: 50,
            child: _Butterfly(
              size: 22,
              rotation: 0.2,
            ),
          ),

          const Positioned(
            bottom: 180,
            right: 55,
            child: _Butterfly(
              size: 32,
              rotation: -0.2,
            ),
          ),

          const Positioned(
            bottom: 100,
            left: 40,
            child: _Butterfly(
              size: 20,
              rotation: 0.4,
            ),
          ),

          // ==============================
          // CONTENIDO PRINCIPAL
          // ==============================

          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  width: screenWidth > 600 ? 500 : double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 42,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.75),
                      width: 1.5,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.38),
                        Colors.white.withOpacity(0.12),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF9C5A65).withOpacity(0.15),
                        blurRadius: 30,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // CORONA
                      Text(
                        '♛',
                        style: TextStyle(
                          fontSize: 55,
                          color: const Color(0xFFC69A4A).withOpacity(0.9),
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'MIS XV AÑOS',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 5,
                          color: const Color(0xFF754B54),
                        ),
                      ),

                      const SizedBox(height: 25),

                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.greatVibes(
                          fontSize: screenWidth > 600 ? 82 : 65,
                          height: 1,
                          color: const Color(0xFF9D5865),
                          shadows: [
                            Shadow(
                              color: Colors.white.withOpacity(0.7),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      Container(
                        width: 80,
                        height: 1,
                        color: const Color(0xFFC69A4A),
                      ),

                      const SizedBox(height: 22),

                      Text(
                        _formatDate(eventDate).toUpperCase(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2.5,
                          color: const Color(0xFF754B54),
                        ),
                      ),

                      if (eventTime.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text(
                          eventTime,
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            letterSpacing: 2,
                            color: const Color(0xFF754B54),
                          ),
                        ),
                      ],

                      const SizedBox(height: 30),

                      const Text(
                        '✦   🦋   ✦',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFC69A4A),
                        ),
                      ),

                      const SizedBox(height: 35),

                      const ScrollIndicator(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Butterfly extends StatelessWidget {
  final double size;
  final double rotation;

  const _Butterfly({
    required this.size,
    required this.rotation,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Text(
        '🦋',
        style: TextStyle(
          fontSize: size,
        ),
      ),
    );
  }
}