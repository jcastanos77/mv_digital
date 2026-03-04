import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/primary_button.dart';
import '../../widgets/scroll_indicator.dart';

class QuinceHero extends StatelessWidget {
  final VoidCallback onPressed;

  const QuinceHero({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://images.unsplash.com/photo-1763959949881-22f1f13cf082?q=80&w=988&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
          ),
          fit: BoxFit.cover,
          filterQuality: FilterQuality.low
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Mis XV Años",
              style: GoogleFonts.playfairDisplay(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Sofía",
              style: GoogleFonts.greatVibes(
                fontSize: 60,
                color: Color(0xFFD4AF37),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [

                Text(
                  "15 · Agosto · 2026",
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    letterSpacing: 3,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "6:00 PM",
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    letterSpacing: 2,
                    color: Colors.white70,
                  ),
                ),


                const ScrollIndicator(),
              ],
            )
          ],
        ),
      ),
    );
  }
}