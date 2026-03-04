import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MVDigitalDemosSection extends StatelessWidget {
  const MVDigitalDemosSection({super.key});

  @override
  Widget build(BuildContext context) {
    const marfil = Color(0xFFF7F5F2);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 140, horizontal: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [

              Text(
                "Nuestros estilos",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 100),

              LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth > 800;

                  return isDesktop
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Expanded(child: _DemoCard(
                        imageUrl:
                        "https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=1200&q=80",
                        title: "XV Glam",
                        description:
                        "Invitación digital moderna para quinceañeras.", route: 'xv-demo',
                      )),
                      SizedBox(width: 60),
                      Expanded(child: _DemoCard(
                        imageUrl:
                        "https://images.unsplash.com/photo-1522673607200-164d1b6ce486?auto=format&fit=crop&w=1200&q=80",
                        title: "Wedding Glam",
                        description:
                        "Experiencia digital sofisticada para bodas.", route: 'wedding-demo',
                      )),
                    ],
                  )
                      : const Column(
                    children: [
                      _DemoCard(
                        imageUrl:
                        "https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=1200&q=80",
                        title: "XV Glam",
                        description:
                        "Invitación digital moderna para quinceañeras.",
                        route: "/xv-demo",
                      ),
                      SizedBox(height: 80),
                      _DemoCard(
                        imageUrl:
                        "https://images.unsplash.com/photo-1522673607200-164d1b6ce486?auto=format&fit=crop&w=1200&q=80",
                        title: "Wedding Glam",
                        description:
                        "Experiencia digital sofisticada para bodas.",
                        route: "/wedding-demo",
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String route;

  const _DemoCard({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    const champagne = Color(0xFFB08A5B);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(height: 22),

        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.playfairDisplay(
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          description,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            height: 1.5,
            color: Colors.black54,
          ),
        ),

        const SizedBox(height: 18),

        GestureDetector(
          onTap: () {},
          child: Text(
            "Ver demo →",
            style: GoogleFonts.montserrat(
              fontSize: 14,
              letterSpacing: 1.5,
              color: champagne,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}