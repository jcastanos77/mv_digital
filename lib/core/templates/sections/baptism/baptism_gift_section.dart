import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BaptismGiftSection extends StatelessWidget {
  final String titleGift;
  final String descriptionGift;

  const BaptismGiftSection({
    super.key,
    required this.titleGift,
    required this.descriptionGift
  });

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFB08D57);
    const text = Color(0xFF444444);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 40,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [

            const Icon(
              Icons.mail_outline_rounded,
              color: gold,
              size: 42,
            ),

            const SizedBox(height: 18),

            Text(
              titleGift,
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 38,
                fontWeight: FontWeight.w600,
                color: gold,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: 55,
              height: 1,
              color: gold,
            ),

            const SizedBox(height: 24),

            Text(
              descriptionGift,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                height: 1.8,
                color: text,
              ),
            ),

            const SizedBox(height: 24),

            const Icon(
              Icons.favorite,
              color: gold,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}