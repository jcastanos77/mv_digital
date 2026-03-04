import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsSection extends StatelessWidget {
  const EventDetailsSection({super.key});

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
            blurRadius: 40,
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
            place: "Santuario de Guadalupe",
            time: "5:00 PM", mapsUrl: 'https://www.google.com/maps/place/Santuario+de+Guadalupe/@27.4897333,-109.9392478,19.16z/data=!4m6!3m5!1s0x86c815d9c4df68e7:0xbbb588efa8c7abdc!8m2!3d27.4898127!4d-109.9390803!16s%2Fg%2F11tdnrbzpr?entry=ttu&g_ep=EgoyMDI2MDIyNS4wIKXMDSoASAFQAw%3D%3D',
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
            place: "La Roca Jardin",
            time: "8:00 PM", mapsUrl: 'https://www.google.com/maps/place/LA+ROCA+JARDIN+DE+EVENTOS/@27.5542956,-109.9275426,16.81z/data=!4m6!3m5!1s0x86c8155a4a39767f:0xe73d8196e9eaf806!8m2!3d27.554048!4d-109.926438!16s%2Fg%2F11f6120k7j?entry=ttu&g_ep=EgoyMDI2MDIyNS4wIKXMDSoASAFQAw%3D%3D',
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
            await launchUrl(url, mode: LaunchMode.externalApplication);
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