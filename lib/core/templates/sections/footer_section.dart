import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  Future<void> _openWhatsApp() async {
    final Uri url = Uri.parse(
      "https://wa.me/5216441491261?text=Hola,%20quiero%20mi%20invitación%20digital",
    );

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 2,
            color: const Color(0xFFE5D6C8),
          ),
          const SizedBox(height: 25),

          Text(
            "INVITACIÓN DIGITAL",
            style: GoogleFonts.montserrat(
              fontSize: 10,
              letterSpacing: 3,
              color: const Color(0xFF8C7B75),
            ),
          ),
          const SizedBox(height: 8),

          Text(
            "MV DIGITAL",
            style: GoogleFonts.playfairDisplay(
              fontSize: 20,
              letterSpacing: 4,
              color: const Color(0xFF3A2726),
            ),
          ),
          const SizedBox(height: 20),

          GestureDetector(
            onTap: _openWhatsApp,
            child: Text(
              "Solicita la tuya aquí",
              style: GoogleFonts.montserrat(
                fontSize: 12,
                letterSpacing: 1.5,
                color: const Color(0xFFC6A23E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}