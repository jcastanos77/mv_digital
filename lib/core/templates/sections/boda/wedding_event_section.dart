import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../models/event_info.dart';

class WeddingEventSection extends StatelessWidget {

  final EventInfo ceremony;
  final EventInfo reception;

  const WeddingEventSection({
    super.key,
    required this.ceremony,
    required this.reception,
  });

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
              children: [

                _EventBlockCentered(
                  imageUrl: ceremony.imageUrl,
                  title: ceremony.title,
                  place: ceremony.place,
                  time: ceremony.time,
                  mapsUrl: ceremony.mapsUrl,
                ),

                const SizedBox(height: 100),

                _EventBlockCentered(
                  imageUrl: reception.imageUrl,
                  title: reception.title,
                  place: reception.place,
                  time: reception.time,
                  mapsUrl: reception.mapsUrl,
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
          child: Image.network(
            imageUrl,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
            cacheWidth: 1400,
          )
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