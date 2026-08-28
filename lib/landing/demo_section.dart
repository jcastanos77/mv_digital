import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../core/widgets/demo_card.dart';

class DemoSection extends StatelessWidget {
  const DemoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 900;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 80 : 150,
        horizontal: isMobile ? 20 : 40,
      ),
      child: Column(
        children: [
          Text(
            "Explora una invitación real",
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 32 : 55,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Diseños elegantes para bodas y XV años",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),

          SizedBox(
            height: isMobile ? 50 : 100,
          ),

          if (isMobile)
            Column(
              children: [
                _buildBoda(context),
                const SizedBox(height: 40),
                _buildXV(context),
                const SizedBox(height: 40),
                _buildBirthday(context),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBoda(context),
                const SizedBox(width: 50),
                _buildXV(context),
                const SizedBox(width: 50),
                _buildBirthday(context),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildBoda(BuildContext context) => DemoCard(
    title: "Boda",
    image: "assets/bodademo.jpeg",
    onTap: () => context.go('/demo/boda'),
  );

  Widget _buildXV(BuildContext context) => DemoCard(
    title: "XV",
    image: "assets/xvdemo.jpeg",
    onTap: () => context.go('/demo/xv'),
  );

  Widget _buildBirthday(BuildContext context) => DemoCard(
    title: "Cumpleaños",
    image: "assets/vaquero.jpg",
    onTap: () => context.go('/demo/birthday'),
  );
}