import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class SpidermanEventSection extends StatelessWidget {
  final DateTime eventDate;
  final String eventTime;
  final String location;
  final String mapsUrl;

  const SpidermanEventSection({
    super.key,
    required this.eventDate,
    required this.eventTime,
    required this.location,
    required this.mapsUrl,
  });

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFE62429);
    const blue = Color(0xFF102A4C);
    const background = Color(0xFF071426);

    return Container(
      width: double.infinity,
      color: background,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 45,
      ),
      child: Column(
        children: [
          Text(
            "¡TU MISIÓN!",
            style: GoogleFonts.bangers(
              color: red,
              fontSize: 38,
              letterSpacing: 3,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "Acompáñame a celebrar este día increíble",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 35),

          Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            padding: const EdgeInsets.all(26),
            decoration: BoxDecoration(
              color: blue,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: red,
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
                _infoRow(
                  icon: Icons.calendar_month_rounded,
                  title: "FECHA",
                  value: _formatDate(eventDate),
                ),

                _divider(),

                _infoRow(
                  icon: Icons.access_time_rounded,
                  title: "HORA",
                  value: eventTime,
                ),

                _divider(),

                _infoRow(
                  icon: Icons.location_on_outlined,
                  title: "LUGAR",
                  value: location,
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
                        size: 20,
                      ),
                      label: Text(
                        "VER UBICACIÓN",
                        style: GoogleFonts.bangers(
                          fontSize: 18,
                          letterSpacing: 2,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: red,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
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
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFE62429),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.white,
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
                style: GoogleFonts.bangers(
                  color: const Color(0xFFE62429),
                  fontSize: 17,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value.isEmpty ? "Por confirmar" : value,
                style: GoogleFonts.montserrat(
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
        color: Colors.white.withOpacity(.10),
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