import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_digital/core/templates/quince_glam.dart';
import 'package:mv_digital/core/templates/wedding_glam.dart';
import '../core/widgets/demo_card.dart';

class DemoSection extends StatelessWidget {
  const DemoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 180,
        horizontal: 40,
      ),
      child: Column(
        children: [

          /// TITULO
          Text(
            "Explora una invitación real",
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: 60,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Diseños elegantes para bodas y XV años",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 120),

          /// DEMOS GRANDES
          LayoutBuilder(
            builder: (context, constraints) {

              /// RESPONSIVE
              bool isMobile = constraints.maxWidth < 900;

              if (isMobile) {
                return Column(
                  children: [
                    _demoBoda(context),
                    const SizedBox(height: 80),
                    _demoXV(context),
                  ],
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  _demoBoda(context),

                  const SizedBox(width: 80),

                  _demoXV(context),

                ],
              );
            },
          )

        ],
      ),
    );
  }

  Widget _demoBoda(BuildContext context) {
    return DemoCard(
      title: "Boda Demo",
      image:
      "https://images.unsplash.com/photo-1606800052052-a08af7148866",
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const WeddingGlamTemplate(),
          ),
        );
      },
    );
  }

  Widget _demoXV(BuildContext context) {
    return DemoCard(
      title: "XV Demo",
      image:
      "https://images.unsplash.com/photo-1511285560929-80b456fea0bc",
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const QuinceGlamPage(),
          ),
        );
      },
    );
  }
}