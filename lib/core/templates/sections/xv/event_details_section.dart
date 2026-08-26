import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsSection extends StatelessWidget {
  final String ceremonyPlace;
  final String ceremonyTime;
  final String ceremonyMaps;

  final String receptionPlace;
  final String receptionTime;
  final String receptionMaps;

  final bool princessTheme;

  const EventDetailsSection({
    super.key,
    required this.ceremonyPlace,
    required this.ceremonyTime,
    required this.ceremonyMaps,
    required this.receptionPlace,
    required this.receptionTime,
    required this.receptionMaps,
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

          const SizedBox(height: 25),

          Text(
            'Detalles del evento',
            style: GoogleFonts.playfairDisplay(
              fontSize: 30,
              color: const Color(0xFF3A2726),
            ),
          ),

          const SizedBox(height: 50),

          _defaultEventBlock(
            title: 'Ceremonia',
            place: ceremonyPlace,
            time: ceremonyTime,
            mapsUrl: ceremonyMaps,
          ),

          const SizedBox(height: 40),

          Container(
            width: 60,
            height: 1,
            color: const Color(0xFFE8DED4),
          ),

          const SizedBox(height: 40),

          _defaultEventBlock(
            title: 'Recepción',
            place: receptionPlace,
            time: receptionTime,
            mapsUrl: receptionMaps,
          ),
        ],
      ),
    );
  }

  Widget _defaultEventBlock({
    required String title,
    required String place,
    required String time,
    required String mapsUrl,
  }) {
    return Column(
      children: [
        Text(
          title.toUpperCase(),
          style: GoogleFonts.montserrat(
            fontSize: 11,
            letterSpacing: 3,
            color: const Color(0xFF8C7B75),
          ),
        ),

        const SizedBox(height: 12),

        Text(
          place,
          textAlign: TextAlign.center,
          style: GoogleFonts.playfairDisplay(
            fontSize: 26,
            color: const Color(0xFF3A2726),
          ),
        ),

        const SizedBox(height: 6),

        Text(
          time,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: const Color(0xFF6E5B55),
          ),
        ),

        const SizedBox(height: 18),

        _locationButton(
          mapsUrl,
          color: const Color(0xFFC6A23E),
        ),
      ],
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
        horizontal: 28,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF6F7),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(
          color: const Color(0xFFD9A0AA).withOpacity(.55),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9D5865).withOpacity(.12),
            blurRadius: 25,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          // CORONA
          const Text(
            '♛',
            style: TextStyle(
              fontSize: 40,
              color: Color(0xFFC69A4A),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'DETALLES DEL EVENTO',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 3,
              color: const Color(0xFFC69A4A),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'Un día de ensueño',
            style: GoogleFonts.playfairDisplay(
              fontSize: 29,
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

          const SizedBox(height: 45),

          _princessEventBlock(
            icon: Icons.church_outlined,
            title: 'Ceremonia',
            place: ceremonyPlace,
            time: ceremonyTime,
            mapsUrl: ceremonyMaps,
          ),

          const SizedBox(height: 35),

          Container(
            width: 80,
            height: 1,
            color: const Color(0xFFD9A0AA).withOpacity(.5),
          ),

          const SizedBox(height: 35),

          _princessEventBlock(
            icon: Icons.celebration_outlined,
            title: 'Recepción',
            place: receptionPlace,
            time: receptionTime,
            mapsUrl: receptionMaps,
          ),
        ],
      ),
    );
  }

  Widget _princessEventBlock({
    required IconData icon,
    required String title,
    required String place,
    required String time,
    required String mapsUrl,
  }) {
    return Column(
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFF3DDE0),
            border: Border.all(
              color: const Color(0xFFC69A4A).withOpacity(.5),
            ),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF9D5865),
            size: 25,
          ),
        ),

        const SizedBox(height: 16),

        Text(
          title.toUpperCase(),
          style: GoogleFonts.montserrat(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            letterSpacing: 3,
            color: const Color(0xFFC69A4A),
          ),
        ),

        const SizedBox(height: 12),

        Text(
          place,
          textAlign: TextAlign.center,
          style: GoogleFonts.playfairDisplay(
            fontSize: 27,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF9D5865),
          ),
        ),

        const SizedBox(height: 8),

        Text(
          time,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 13,
            letterSpacing: 1,
            color: const Color(0xFF754B54),
          ),
        ),

        const SizedBox(height: 20),

        GestureDetector(
          onTap: () => _openMaps(mapsUrl),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 11,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xFF9D5865),
            ),
            child: Text(
              'VER UBICACIÓN',
              style: GoogleFonts.montserrat(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ========================================
  // UTILIDADES
  // ========================================

  Widget _locationButton(
      String mapsUrl, {
        required Color color,
      }) {
    return GestureDetector(
      onTap: () => _openMaps(mapsUrl),
      child: Text(
        'Ver ubicación',
        style: GoogleFonts.montserrat(
          fontSize: 12,
          letterSpacing: 1.5,
          color: color,
        ),
      ),
    );
  }

  Future<void> _openMaps(String mapsUrl) async {
    if (mapsUrl.isEmpty) return;

    final Uri url = Uri.parse(mapsUrl);

    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }
}