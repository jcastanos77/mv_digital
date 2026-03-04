import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                ),

                SizedBox(height: 100),

                _EventBlockCentered(
                  imageUrl:
                  "https://images.unsplash.com/photo-1520854221256-17451cc331bf?auto=format&fit=crop&w=1400&q=80",
                  title: "RECEPCIÓN",
                  place: "Hacienda Los Olivos",
                  time: "8:00 PM",
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

  const _EventBlockCentered({
    required this.imageUrl,
    required this.title,
    required this.place,
    required this.time,
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

        Text(
          "Ver ubicación",
          style: GoogleFonts.montserrat(
            fontSize: 13,
            letterSpacing: 2,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}