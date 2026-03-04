import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class WeddingEventSection extends StatelessWidget {
  const WeddingEventSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 140),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 850),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: const [

                _EventBlockCentered(
                  imageUrl:
                  "https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=1400&q=80",
                  title: "CEREMONIA",
                  place: "Parroquia San José",
                  time: "5:00 PM",
                  mapsUrl: 'https://www.google.com/maps/place/Santuario+de+Guadalupe/@27.4897333,-109.9392478,19.16z/data=!4m6!3m5!1s0x86c815d9c4df68e7:0xbbb588efa8c7abdc!8m2!3d27.4898127!4d-109.9390803!16s%2Fg%2F11tdnrbzpr?entry=ttu&g_ep=EgoyMDI2MDIyNS4wIKXMDSoASAFQAw%3D%3D',
                ),

                SizedBox(height: 100),

                _EventBlockCentered(
                  imageUrl:
                  "https://images.unsplash.com/photo-1520854221256-17451cc331bf?auto=format&fit=crop&w=1400&q=80",
                  title: "RECEPCIÓN",
                  place: "Hacienda Los Olivos",
                  time: "8:00 PM",
                  mapsUrl: 'https://www.google.com/maps/place/LA+ROCA+JARDIN+DE+EVENTOS/@27.5542956,-109.9275426,16.81z/data=!4m6!3m5!1s0x86c8155a4a39767f:0xe73d8196e9eaf806!8m2!3d27.554048!4d-109.926438!16s%2Fg%2F11f6120k7j?entry=ttu&g_ep=EgoyMDI2MDIyNS4wIKXMDSoASAFQAw%3D%3D',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EventBlockCentered extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String place;
  final String time;
  final String mapsUrl;

  const _EventBlockCentered({
    required this.imageUrl,
    required this.title,
    required this.place,
    required this.time,
    required this.mapsUrl
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(height: 40),

        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            letterSpacing: 5,
            color: const Color(0xFF8A8A8A),
          ),
        ),

        const SizedBox(height: 18),

        Text(
          place,
          textAlign: TextAlign.center,
          style: GoogleFonts.playfairDisplay(
            fontSize: 36,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF1F1F1F),
          ),
        ),

        const SizedBox(height: 14),

        Text(
          time,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: const Color(0xFF6A6A6A),
          ),
        ),

        const SizedBox(height: 30),

        GestureDetector(
          onTap: () async {
            final Uri url = Uri.parse(mapsUrl);
            await launchUrl(url, mode: LaunchMode.externalApplication);
          },
          child: Text(
            "Ver ubicación",
            style: GoogleFonts.montserrat(
              fontSize: 13,
              letterSpacing: 2,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}