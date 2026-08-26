import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/primary_button.dart';

class RsvpSection extends StatefulWidget {
  final String invitationId;
  final bool princessTheme;

  const RsvpSection({
    super.key,
    required this.invitationId,
    this.princessTheme = false,
  });

  @override
  State<RsvpSection> createState() => _RsvpSectionState();
}

class _RsvpSectionState extends State<RsvpSection> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _guestsController = TextEditingController();

  String attendance = "Sí";
  bool submitted = false;
  bool loading = false;

  static const _roseDark = Color(0xFF9D5865);
  static const _roseMedium = Color(0xFFD9A0AA);
  static const _roseLight = Color(0xFFF3DDE0);
  static const _gold = Color(0xFFC69A4A);

  @override
  void dispose() {
    _nameController.dispose();
    _guestsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.princessTheme
        ? _buildPrincessTheme()
        : _buildDefaultTheme();
  }

  // ========================================
  // DISEÑO ORIGINAL
  // ========================================

  Widget _buildDefaultTheme() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(
        vertical: 70,
        horizontal: 30,
      ),
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

          _animatedContent(),
        ],
      ),
    );
  }

  // ========================================
  // TEMA PRINCESA
  // ========================================

  Widget _buildPrincessTheme() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(
        vertical: 60,
        horizontal: 30,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF6F7),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(
          color: _roseMedium.withOpacity(.55),
        ),
        boxShadow: [
          BoxShadow(
            color: _roseDark.withOpacity(.10),
            blurRadius: 25,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            '♛',
            style: TextStyle(
              fontSize: 38,
              color: _gold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            'CONFIRMACIÓN',
            style: GoogleFonts.montserrat(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 3,
              color: _gold,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            '¿Nos acompañas?',
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: _roseDark,
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            '✦  🦋  ✦',
            style: TextStyle(
              fontSize: 18,
              color: _gold,
            ),
          ),

          const SizedBox(height: 40),

          _animatedContent(),
        ],
      ),
    );
  }

  // ========================================
  // CONTENIDO ANIMADO
  // ========================================

  Widget _animatedContent() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: submitted
          ? _successMessage()
          : _formContent(),
    );
  }

  // ========================================
  // FORMULARIO
  // ========================================

  Widget _formContent() {
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
            dropdownColor:
            widget.princessTheme ? const Color(0xFFFDF6F7) : Colors.white,
            value: attendance,
            style: TextStyle(
              color: widget.princessTheme ? _roseDark : Colors.black,
            ),
            decoration: _inputDecoration("¿Asistirás?"),
            items: [
              DropdownMenuItem(
                value: "Sí",
                child: Text(
                  "Sí asistiré",
                  style: TextStyle(
                    color: widget.princessTheme
                        ? _roseDark
                        : Colors.black,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: "No",
                child: Text(
                  "No podré asistir",
                  style: TextStyle(
                    color: widget.princessTheme
                        ? _roseDark
                        : Colors.black,
                  ),
                ),
              ),
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

          loading
              ? CircularProgressIndicator(
            color: widget.princessTheme
                ? _roseDark
                : const Color(0xFFD4AF37),
          )
              : widget.princessTheme
              ? _princessButton()
              : PrimaryButton(
            text: "Confirmar asistencia",
            onPressed: _submitRsvp,
          ),
        ],
      ),
    );
  }

  // ========================================
  // BOTÓN PRINCESA
  // ========================================

  Widget _princessButton() {
    return GestureDetector(
      onTap: _submitRsvp,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 17,
        ),
        decoration: BoxDecoration(
          color: _roseDark,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: _roseDark.withOpacity(.25),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'CONFIRMAR ASISTENCIA',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  // ========================================
  // GUARDAR RSVP
  // ========================================

  Future<void> _submitRsvp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('invitations')
          .doc(widget.invitationId)
          .collection('rsvps')
          .add({
        'nombre': _nameController.text.trim(),
        'asistencia': attendance,
        'invitados': int.tryParse(_guestsController.text) ?? 0,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      setState(() {
        submitted = true;
        loading = false;
        _nameController.clear();
        _guestsController.clear();
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Ocurrió un error al confirmar. Intenta nuevamente.',
          ),
        ),
      );
    }
  }

  // ========================================
  // CONFIRMACIÓN EXITOSA
  // ========================================

  Widget _successMessage() {
    return Column(
      key: const ValueKey('success'),
      children: [
        if (widget.princessTheme) ...[
          const Text(
            '🦋',
            style: TextStyle(fontSize: 45),
          ),

          const SizedBox(height: 15),
        ],

        Text(
          "RSVP CONFIRMADO",
          style: GoogleFonts.montserrat(
            letterSpacing: 2,
            fontSize: 11,
            color: widget.princessTheme
                ? _gold
                : const Color(0xFF4A2C2A),
          ),
        ),

        const SizedBox(height: 20),

        Text(
          "¡Gracias por confirmar!",
          textAlign: TextAlign.center,
          style: GoogleFonts.playfairDisplay(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: widget.princessTheme
                ? _roseDark
                : const Color(0xFF4A2C2A),
          ),
        ),

        const SizedBox(height: 12),

        Text(
          widget.princessTheme
              ? "Te esperamos para celebrar esta noche de ensueño ✨"
              : "Te esperamos en este día tan especial ✨",
          style: GoogleFonts.montserrat(
            fontSize: 14,
            height: 1.5,
            color: widget.princessTheme
                ? const Color(0xFF754B54)
                : const Color(0xFF4A2C2A),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // ========================================
  // INPUT
  // ========================================

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: widget.princessTheme
                ? _roseDark.withOpacity(.05)
                : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          color: widget.princessTheme ? _roseDark : Colors.black,
        ),
        validator: (value) =>
        value == null || value.trim().isEmpty
            ? "Este campo es obligatorio"
            : null,
        decoration: _inputDecoration(hint),
      ),
    );
  }

  // ========================================
  // DECORACIÓN INPUT
  // ========================================

  InputDecoration _inputDecoration(String hint) {
    final borderColor = widget.princessTheme
        ? _roseMedium
        : const Color(0xFFD4AF37);

    final focusedColor = widget.princessTheme
        ? _roseDark
        : const Color(0xFFB8962E);

    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: widget.princessTheme
            ? _roseDark.withOpacity(.55)
            : Colors.grey,
      ),
      filled: true,
      fillColor: widget.princessTheme
          ? const Color(0xFFFFFBFB)
          : Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: focusedColor,
          width: 2,
        ),
      ),
    );
  }
}