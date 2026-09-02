import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MarioBrosEventSection extends StatelessWidget {
  final DateTime eventDate;
  final String eventTime;
  final String location;
  final String mapsUrl;

  const MarioBrosEventSection({
    super.key,
    required this.eventDate,
    required this.eventTime,
    required this.location,
    required this.mapsUrl,
  });

  @override
  Widget build(BuildContext context) {
    final day = eventDate.day.toString();
    final month = _monthName(eventDate.month).toUpperCase();
    final year = eventDate.year.toString();

    return Container(
      width: double.infinity,
      color: const Color(0xFFFFF8E7),
      child: Stack(
        children: [
          // ─────────────────────────────────────────
          // DECORACIÓN
          // ─────────────────────────────────────────

          const Positioned(
            top: 35,
            left: 20,
            child: _Cloud(scale: .55),
          ),

          const Positioned(
            top: 100,
            right: 20,
            child: _Cloud(scale: .4),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 72,
            ),
            child: Column(
              children: [
                // ─────────────────────────────────────
                // HEADER
                // ─────────────────────────────────────

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _PixelLine(),

                    const SizedBox(width: 12),

                    Text(
                      'SIGUIENTE NIVEL',
                      style: GoogleFonts.baloo2(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        color: const Color(0xFFE3262E),
                      ),
                    ),

                    const SizedBox(width: 12),

                    const _PixelLine(),
                  ],
                ),

                const SizedBox(height: 14),

                Text(
                  '¡AQUÍ SERÁ LA AVENTURA!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.baloo2(
                    fontSize: 29,
                    height: 1,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF263238),
                  ),
                ),

                const SizedBox(height: 38),

                // ─────────────────────────────────────
                // FECHA
                // ─────────────────────────────────────

                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(
                    maxWidth: 430,
                  ),
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: const Color(0xFFFFD83D),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // CALENDARIO
                      Container(
                        width: 72,
                        height: 78,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3262E),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              day,
                              style: GoogleFonts.baloo2(
                                fontSize: 31,
                                height: 1,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              month,
                              style: GoogleFonts.baloo2(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                letterSpacing: .8,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 18),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'FECHA DEL EVENTO',
                              style: GoogleFonts.baloo2(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.3,
                                color: const Color(0xFF8A8A8A),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '$day DE $month',
                              style: GoogleFonts.baloo2(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF263238),
                              ),
                            ),
                            Text(
                              year,
                              style: GoogleFonts.baloo2(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF2D6CDF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // ─────────────────────────────────────
                // HORA
                // ─────────────────────────────────────

                _InfoCard(
                  icon: Icons.access_time_rounded,
                  title: 'HORA',
                  value: eventTime,
                  iconColor: const Color(0xFF2D6CDF),
                ),

                const SizedBox(height: 14),

                // ─────────────────────────────────────
                // LUGAR
                // ─────────────────────────────────────

                _InfoCard(
                  icon: Icons.location_on_rounded,
                  title: 'LUGAR',
                  value: location,
                  iconColor: const Color(0xFF2E9B39),
                ),

                const SizedBox(height: 28),

                // ─────────────────────────────────────
                // BOTÓN MAPS
                // ─────────────────────────────────────

                if (mapsUrl.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _openMaps(mapsUrl),
                      icon: const Icon(
                        Icons.navigation_rounded,
                        size: 20,
                      ),
                      label: Text(
                        '¿CÓMO LLEGO?',
                        style: GoogleFonts.baloo2(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E9B39),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          vertical: 17,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 42),

                // ─────────────────────────────────────
                // BLOQUE DECORATIVO
                // ─────────────────────────────────────

                const _QuestionBlock(),
              ],
            ),
          ),

          // ─────────────────────────────────────────
          // SUELO
          // ─────────────────────────────────────────

          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _PixelGround(),
          ),
        ],
      ),
    );
  }

  Future<void> _openMaps(String url) async {
    final uri = Uri.tryParse(url);

    if (uri == null) return;

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  String _monthName(int month) {
    const months = [
      '',
      'ENERO',
      'FEBRERO',
      'MARZO',
      'ABRIL',
      'MAYO',
      'JUNIO',
      'JULIO',
      'AGOSTO',
      'SEPTIEMBRE',
      'OCTUBRE',
      'NOVIEMBRE',
      'DICIEMBRE',
    ];

    return months[month];
  }
}

// ═══════════════════════════════════════════════════════
// INFO CARD
// ═══════════════════════════════════════════════════════

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color iconColor;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        maxWidth: 430,
      ),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE8DFC8),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 25,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.baloo2(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.4,
                    color: const Color(0xFF8A8A8A),
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value.isEmpty ? 'Por confirmar' : value,
                  style: GoogleFonts.baloo2(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF263238),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// QUESTION BLOCK
// ═══════════════════════════════════════════════════════

class _QuestionBlock extends StatelessWidget {
  const _QuestionBlock();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: const Color(0xFFFFD83D),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE5A900),
          width: 4,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFD39A00),
            offset: Offset(0, 5),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        '?',
        style: GoogleFonts.baloo2(
          fontSize: 34,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// CLOUD
// ═══════════════════════════════════════════════════════

class _Cloud extends StatelessWidget {
  final double scale;

  const _Cloud({
    this.scale = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: SizedBox(
        width: 115,
        height: 55,
        child: Stack(
          children: [
            Positioned(
              left: 10,
              bottom: 5,
              child: Container(
                width: 95,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.85),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: 4,
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.85),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: 55,
              top: 12,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.85),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// PIXEL LINE
// ═══════════════════════════════════════════════════════

class _PixelLine extends StatelessWidget {
  const _PixelLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 4,
      color: const Color(0xFFE3262E),
    );
  }
}

// ═══════════════════════════════════════════════════════
// PIXEL GROUND
// ═══════════════════════════════════════════════════════

class _PixelGround extends StatelessWidget {
  const _PixelGround();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 7,
          color: const Color(0xFF2E9B39),
        ),
        Container(
          height: 28,
          color: const Color(0xFF8A542E),
          child: Row(
            children: List.generate(
              12,
                  (index) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF633B22),
                        width: 1.5,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}