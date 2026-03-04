import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeddingRsvpSection extends StatefulWidget {
  const WeddingRsvpSection({super.key});

  @override
  State<WeddingRsvpSection> createState() => _WeddingRsvpSectionState();
}

class _WeddingRsvpSectionState extends State<WeddingRsvpSection> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController guestsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        children: [

          /// Línea decorativa sutil
          Container(
            width: 40,
            height: 2,
            color: const Color(0xFFC6A23E),
          ),

          const SizedBox(height: 30),

          Text(
            "Confirmación de asistencia",
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: 28,
              color: const Color(0xFF2B2B2B),
            ),
          ),

          const SizedBox(height: 50),

          /// Nombre
          TextField(
            controller: nameController,
            decoration: _inputDecoration("Nombre completo"),
          ),

          const SizedBox(height: 25),

          /// Número de invitados
          TextField(
            controller: guestsController,
            keyboardType: TextInputType.number,
            decoration: _inputDecoration("Número de invitados"),
          ),

          const SizedBox(height: 50),

          /// Botón confirmar
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC6A23E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              onPressed: () {
                // Aquí luego conectamos WhatsApp o Firebase
              },
              child: Text(
                "Confirmar asistencia",
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.montserrat(
        fontSize: 13,
        color: const Color(0xFF9A9A9A),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Color(0xFFE5E5E5),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Color(0xFFC6A23E),
          width: 1.2,
        ),
      ),
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    );
  }
}