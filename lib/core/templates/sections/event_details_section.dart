import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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

  const EventDetailsSection({
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
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 30),
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
            "Detalles del evento",
            style: GoogleFonts.playfairDisplay(
              fontSize: 30,
              color: const Color(0xFF3A2726),
            ),
          ),

          const SizedBox(height: 50),

          _eventBlock(
            title: "Ceremonia",
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

          _eventBlock(
            title: "Recepción",
            place: receptionPlace,
            time: receptionTime,
            mapsUrl: receptionMaps,
          ),

        ],
      ),
    );
  }

  Widget _eventBlock({
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

        GestureDetector(
          onTap: () async {

            final Uri url = Uri.parse(mapsUrl);

            await launchUrl(
              url,
              mode: LaunchMode.externalApplication,
            );

          },
          child: Text(
            "Ver ubicación",
            style: GoogleFonts.montserrat(
              fontSize: 12,
              letterSpacing: 1.5,
              color: const Color(0xFFC6A23E),
            ),
          ),
        ),
      ],
    );
  }
}