import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class PokemonEventSection extends StatelessWidget {
  final DateTime eventDate;
  final String eventTime;
  final String location;
  final String mapsUrl;

  const PokemonEventSection({
    super.key,
    required this.eventDate,
    required this.eventTime,
    required this.location,
    required this.mapsUrl,
  });

  @override
  Widget build(BuildContext context) {
    const yellow = Color(0xFFFFCB05);
    const red = Color(0xFFE53935);
    const blue = Color(0xFF1B356E);
    const background = Color(0xFF0A1B3D);

    return Container(
      width: double.infinity,
      color: background,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 45,
      ),
      child: Column(
        children: [
          /// POKÉBOLA
          const _SectionPokeBall(),

          const SizedBox(height: 14),

          /// TÍTULO
          Text(
            "¡TU AVENTURA!",
            style: GoogleFonts.fredoka(
              color: yellow,
              fontSize: 34,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "Todo gran entrenador necesita saber a dónde ir",
            textAlign: TextAlign.center,
            style: GoogleFonts.fredoka(
              color: Colors.white70,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 35),

          /// TARJETA POKÉDEX
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: blue,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: yellow,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.30),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                /// HEADER TIPO POKÉDEX
                Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                        color: red,
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 8),

                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: yellow,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(.40),
                        ),
                      ),
                    ),

                    const SizedBox(width: 6),

                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFF55C1FF),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(.40),
                        ),
                      ),
                    ),

                    const Spacer(),

                    Text(
                      "EVENTO",
                      style: GoogleFonts.fredoka(
                        color: Colors.white54,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                _infoRow(
                  icon: Icons.calendar_month_rounded,
                  title: "FECHA",
                  value: _formatDate(eventDate),
                  color: red,
                ),

                _divider(),

                _infoRow(
                  icon: Icons.access_time_rounded,
                  title: "HORA",
                  value: eventTime,
                  color: yellow,
                ),

                _divider(),

                _infoRow(
                  icon: Icons.location_on_rounded,
                  title: "UBICACIÓN",
                  value: location,
                  color: const Color(0xFF55C1FF),
                ),

                if (mapsUrl.trim().isNotEmpty) ...[
                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      onPressed: () => _openMaps(mapsUrl),
                      icon: const Icon(
                        Icons.navigation_rounded,
                        size: 21,
                      ),
                      label: Text(
                        "IR A LA UBICACIÓN",
                        style: GoogleFonts.fredoka(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: yellow,
                        foregroundColor: const Color(0xFF0A1B3D),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF0A1B3D),
            size: 24,
          ),
        ),

        const SizedBox(width: 18),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.fredoka(
                  color: color,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value.isEmpty ? "Por confirmar" : value,
                style: GoogleFonts.fredoka(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Container(
        height: 1,
        color: Colors.white.withOpacity(.12),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat(
      "dd 'de' MMMM 'de' yyyy",
      "es",
    ).format(date);
  }

  Future<void> _openMaps(String url) async {
    final uri = Uri.tryParse(url);

    if (uri == null) return;

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }
}

/// POKÉBOLA DECORATIVA
class _SectionPokeBall extends StatelessWidget {
  const _SectionPokeBall();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 38,
      height: 38,
      child: CustomPaint(
        painter: _SectionPokeBallPainter(),
      ),
    );
  }
}

class _SectionPokeBallPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius = size.width / 2;

    final redPaint = Paint()
      ..color = const Color(0xFFE53935);

    final whitePaint = Paint()
      ..color = Colors.white;

    final darkPaint = Paint()
      ..color = const Color(0xFF0A1B3D);

    final borderPaint = Paint()
      ..color = const Color(0xFF0A1B3D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    /// CÍRCULO BASE
    canvas.drawCircle(
      center,
      radius,
      whitePaint,
    );

    /// MITAD ROJA
    final redPath = Path()
      ..addArc(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
        3.141592,
        3.141592,
      )
      ..close();

    canvas.drawPath(
      redPath,
      redPaint,
    );

    /// LÍNEA CENTRAL
    canvas.drawRect(
      Rect.fromLTWH(
        0,
        center.dy - 2,
        size.width,
        4,
      ),
      darkPaint,
    );

    /// BOTÓN CENTRAL
    canvas.drawCircle(
      center,
      radius * .30,
      whitePaint,
    );

    canvas.drawCircle(
      center,
      radius * .30,
      borderPaint,
    );

    canvas.drawCircle(
      center,
      radius * .12,
      darkPaint,
    );

    /// BORDE
    canvas.drawCircle(
      center,
      radius - 1,
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(
      covariant CustomPainter oldDelegate,
      ) {
    return false;
  }
}