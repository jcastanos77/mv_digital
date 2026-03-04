import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_digital/core/templates/quince_glam.dart';
import 'package:mv_digital/core/templates/wedding_glam.dart';
import '../core/widgets/demo_card.dart';

class DemoSection extends StatelessWidget {
  const DemoSection({super.key});

  @override
  Widget build(BuildContext context) {

    bool isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 100 : 180,
        horizontal: isMobile ? 20 : 40,
      ),
      child: Column(
        children: [

          /// TITULO
          Text(
            "Explora una invitación real",
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 36 : 60,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "Diseños elegantes para bodas y XV años",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 16 : 20,
              color: Colors.white70,
            ),
          ),

          SizedBox(height: isMobile ? 60 : 120),

          /// DEMOS
          LayoutBuilder(
            builder: (context, constraints) {

              bool isMobile = constraints.maxWidth < 900;

              if (isMobile) {
                return Column(
                  children: [
                    _demoBoda(context),
                    const SizedBox(height: 60),
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