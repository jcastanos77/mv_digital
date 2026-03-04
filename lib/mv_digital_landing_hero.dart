import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_digital/core/templates/quince_glam.dart';
import 'package:mv_digital/core/templates/wedding_glam.dart';

class MVDigitalLandingHero extends StatelessWidget {
  const MVDigitalLandingHero({super.key});

  @override
  Widget build(BuildContext context) {
    const marfil = Color(0xFFF7F5F2);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 120),
      color: marfil,
      child: Column(
        children: [

          Text(
            "MV Digital",
            style: GoogleFonts.playfairDisplay(
              fontSize: 52,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "Invitaciones digitales elegantes\npara momentos inolvidables.",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 17,
              height: 1.6,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class MVDigitalDemoCards extends StatelessWidget {
  const MVDigitalDemoCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Column(
        children: [

          _DemoCard(
            title: "XV Glam",
            image:
            "https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=1200&q=80",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const QuinceGlamPage(),
                ),
              );
            },
          ),

          const SizedBox(height: 40),

          _DemoCard(
            title: "Wedding Glam",
            image:
            "https://images.unsplash.com/photo-1522673607200-164d1b6ce486?auto=format&fit=crop&w=1200&q=80",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const WeddingGlamTemplate(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const _DemoCard({
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const champagne = Color(0xFFB08A5B);

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          alignment: Alignment.center,
          children: [

            CachedNetworkImage(
              imageUrl: image,
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.low,
            ),

            Container(
              height: 260,
              color: Colors.black.withOpacity(0.35),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  title,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Abrir demo",
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    letterSpacing: 2,
                    color: champagne,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}