import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/primary_button.dart';

class RsvpSection extends StatefulWidget {
  const RsvpSection({super.key});

  @override
  State<RsvpSection> createState() => _RsvpSectionState();
}

class _RsvpSectionState extends State<RsvpSection> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _guestsController = TextEditingController();

  String attendance = "Sí";
  bool submitted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 2,
            color: const Color(0xFFD4AF37),
          ),
          const SizedBox(height: 20),
          Text(
            "Confirmación de asistencia",
            style: GoogleFonts.playfairDisplay(
              fontSize: 26,
              color: const Color(0xFF4A2C2A),
            ),
          ),
          const SizedBox(height: 40),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: submitted
                ? _successMessage()
                : _formContent(),
          )

        ],
      ),
    );
  }

  Widget _formContent(){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _inputField(
            controller: _nameController,
            hint: "Nombre completo",
          ),
          const SizedBox(height: 20),

          DropdownButtonFormField<String>(
            dropdownColor: Colors.white,
            style: const TextStyle(
              color: Colors.white,
            ),
            value: attendance,
            decoration: _inputDecoration("¿Asistirás?"),
            items: const [
              DropdownMenuItem(value: "Sí", child: Text("Sí asistiré",  style: const TextStyle(
                color: Colors.black,
              ),)),
              DropdownMenuItem(value: "No", child: Text("No podré asistir",  style: const TextStyle(
                color: Colors.black,
              ),)),
            ],
            onChanged: (value) {
              setState(() {
                attendance = value!;
              });
            },
          ),

          const SizedBox(height: 20),

          _inputField(
            controller: _guestsController,
            hint: "Número de invitados",
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 30),

          PrimaryButton(
            text: "Confirmar asistencia",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  submitted = true;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _successMessage() {
    return Column(
      children: [
        Text(
          "RSVP Confirmado",
          style: GoogleFonts.montserrat(
            letterSpacing: 2,
            fontSize: 12,
            color: Color(0xFF4A2C2A),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "¡Gracias por confirmar!",
          style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            color: const Color(0xFF4A2C2A),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Te esperamos en este día tan especial ✨",
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: const Color(0xFF4A2C2A),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.black,
        ),
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) =>
        value == null || value.isEmpty ? "Este campo es obligatorio" : null,
        decoration: _inputDecoration(hint),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xFFD4AF37)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xFFD4AF37)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xFFB8962E), width: 2),
      ),
    );
  }
}