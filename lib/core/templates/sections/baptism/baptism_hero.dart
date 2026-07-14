
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BaptismHero extends StatelessWidget {
  final String title;
  final String heroImage;
  final DateTime eventDate;

  const BaptismHero({
    super.key,
    required this.title,
    required this.heroImage,
    required this.eventDate,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 720,
      child: Stack(
        children: [

          Positioned.fill(
      child: Image.network(
        heroImage,
        fit: BoxFit.cover,
      ),
    ),

          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(0, 0, 0, .15),
                    Color.fromRGBO(0, 0, 0, .55),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                  bottom: 80,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(.08),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFB08D57).withOpacity(.45),
                            blurRadius: 18,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(
                          "assets/cross_gold.png",
                          width: 72,
                          height: 72,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "Mi Bautizo",
                      style: GoogleFonts.cormorantGaramond(
                        color: Colors.white70,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.greatVibes(
                        color: Colors.white,
                        fontSize: 58,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Container(
                      width: 60,
                      height: 1,
                      color: Colors.white70,
                    ),

                    const SizedBox(height: 18),

                    Text(
                      DateFormat(
                        "dd/MM/yyyy",
                      )
                          .format(eventDate)
                          .toUpperCase(),
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 45,
              decoration: const BoxDecoration(
                color: Color(0xFFF8F5F1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}