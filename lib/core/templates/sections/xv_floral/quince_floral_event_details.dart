import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class QuinceFloralEventDetails extends StatelessWidget {
  final String ceremonyPlace;
  final String ceremonyTime;
  final String ceremonyMaps;

  final String receptionPlace;
  final String receptionTime;
  final String receptionMaps;

  const QuinceFloralEventDetails({
    super.key,
    required this.ceremonyPlace,
    required this.ceremonyTime,
    required this.ceremonyMaps,
    required this.receptionPlace,
    required this.receptionTime,
    required this.receptionMaps,
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
          Text(
            'DETALLES DEL EVENTO',
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
            'Un día para recordar',
            textAlign: TextAlign.center,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3B3530),
            ),
          ),

          const SizedBox(height: 20),

          _Ornament(),

          const SizedBox(height: 55),

          _EventBlock(
            icon: Icons.church_outlined,
            title: 'CEREMONIA',
            place: ceremonyPlace,
            time: ceremonyTime,
            mapsUrl: ceremonyMaps,
          ),

          const SizedBox(height: 50),

          Container(
            width: 1,
            height: 50,
            color: const Color(0xFFDCC48D),
          ),

          const SizedBox(height: 50),

          _EventBlock(
            icon: Icons.celebration_outlined,
            title: 'RECEPCIÓN',
            place: receptionPlace,
            time: receptionTime,
            mapsUrl: receptionMaps,
          ),
        ],
      ),
    );
  }
}

class _EventBlock extends StatelessWidget {
  final IconData icon;
  final String title;
  final String place;
  final String time;
  final String mapsUrl;

  const _EventBlock({
    required this.icon,
    required this.title,
    required this.place,
    required this.time,
    required this.mapsUrl,
  });

  Future<void> _openMaps() async {
    if (mapsUrl.isEmpty) return;

    final uri = Uri.tryParse(mapsUrl);

    if (uri == null) return;

    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFFFFAF0),
            border: Border.all(
              color: const Color(0xFFDCC48D),
            ),
          ),
          child: Icon(
            icon,
            size: 28,
            color: const Color(0xFFC49A45),
          ),
        ),

        const SizedBox(height: 22),

        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            letterSpacing: 3,
            color: const Color(0xFFC49A45),
          ),
        ),

        const SizedBox(height: 18),

        Text(
          place,
          textAlign: TextAlign.center,
          style: GoogleFonts.cormorantGaramond(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF3B3530),
          ),
        ),

        const SizedBox(height: 10),

        Text(
          time,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 13,
            letterSpacing: 1.5,
            color: const Color(0xFF625951),
          ),
        ),

        if (mapsUrl.isNotEmpty) ...[
          const SizedBox(height: 28),

          GestureDetector(
            onTap: _openMaps,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 13,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFC49A45),
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                'VER UBICACIÓN',
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  color: const Color(0xFFC49A45),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _Ornament extends StatelessWidget {
  const _Ornament();

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