import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class RsvpsFloralSectionSection extends StatefulWidget {
  final String invitationId;
  final bool princessTheme;

  const RsvpsFloralSectionSection({
    super.key,
    required this.invitationId,
    this.princessTheme = false,
  });

  @override
  State<RsvpsFloralSectionSection> createState() => _RsvpSectionFloralState();
}

class _RsvpSectionFloralState extends State<RsvpsFloralSectionSection> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _guestsController = TextEditingController();

  bool _willAttend = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _guestsController.dispose();
    super.dispose();
  }

  Future<void> _confirmAttendance() async {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      _showMessage('Por favor ingresa tu nombre.');
      return;
    }

    final guests = int.tryParse(_guestsController.text.trim()) ?? 1;

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('invitations')
          .doc(widget.invitationId)
          .collection('confirmations')
          .add({
        'name': name,
        'willAttend': _willAttend,
        'guests': guests,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      _nameController.clear();
      _guestsController.clear();

      _showSuccessDialog();
    } catch (e) {
      if (!mounted) return;

      _showMessage(
        'Ocurrió un error al confirmar tu asistencia.',
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFFCF8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          title: Text(
            _willAttend
                ? '¡Gracias por confirmar!'
                : 'Respuesta registrada',
            textAlign: TextAlign.center,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3B3530),
            ),
          ),
          content: Text(
            _willAttend
                ? 'Nos encantará compartir este día tan especial contigo.'
                : 'Gracias por hacernos saber. Te extrañaremos en este día tan especial.',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              height: 1.6,
              color: const Color(0xFF625951),
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'ACEPTAR',
                  style: GoogleFonts.montserrat(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                    color: const Color(0xFFC49A45),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFFFCF8),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 70,
      ),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          maxWidth: 620,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 55,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFCF8),
          borderRadius: BorderRadius.circular(36),
          border: Border.all(
            color: const Color(0xFFE7D7B0),
            width: 1.2,
          ),
        ),
        child: Column(
          children: [
            const _RsvpOrnament(),

            const SizedBox(height: 42),

            Text(
              'CONFIRMA TU ASISTENCIA',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: 4,
                color: const Color(0xFFC49A45),
              ),
            ),

            const SizedBox(height: 18),

            Text(
              '¿Nos acompañas?',
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                fontSize: 52,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF3B3530),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'Será un honor compartir este día tan especial contigo',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 15,
                height: 1.6,
                color: const Color(0xFF8A8178),
              ),
            ),

            const SizedBox(height: 38),

            TextField(
              controller: _nameController,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: const Color(0xFF3B3530),
              ),
              decoration: _inputDecoration(
                hint: 'Nombre completo',
                icon: Icons.person_outline,
              ),
            ),

            const SizedBox(height: 18),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: const Color(0xFFE7D7B0),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _attendanceOption(
                      selected: _willAttend,
                      icon: Icons.favorite_border,
                      text: 'Sí asistiré',
                      onTap: () {
                        setState(() {
                          _willAttend = true;
                        });
                      },
                    ),
                  ),

                  Expanded(
                    child: _attendanceOption(
                      selected: !_willAttend,
                      icon: Icons.close,
                      text: 'No podré',
                      onTap: () {
                        setState(() {
                          _willAttend = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            if (_willAttend)
              TextField(
                controller: _guestsController,
                keyboardType: TextInputType.number,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: const Color(0xFF3B3530),
                ),
                decoration: _inputDecoration(
                  hint: 'Número de invitados',
                  icon: Icons.groups_outlined,
                ),
              ),

            if (_willAttend) const SizedBox(height: 30),

            if (!_willAttend) const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : _confirmAttendance,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC49A45),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _willAttend
                          ? Icons.favorite_border
                          : Icons.check,
                      size: 22,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _willAttend
                          ? 'CONFIRMAR ASISTENCIA'
                          : 'ENVIAR RESPUESTA',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.montserrat(
        fontSize: 15,
        color: const Color(0xFF8A8178),
      ),
      prefixIcon: Icon(
        icon,
        color: const Color(0xFFC49A45),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 20,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(
          color: Color(0xFFE7D7B0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(
          color: Color(0xFFC49A45),
          width: 1.5,
        ),
      ),
    );
  }

  Widget _attendanceOption({
    required bool selected,
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(21),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 108,
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFC49A45)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(21),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selected
                  ? Colors.white
                  : const Color(0xFFC49A45),
              size: 27,
            ),

            const SizedBox(height: 10),

            Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: selected
                    ? Colors.white
                    : const Color(0xFF625951),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RsvpOrnament extends StatelessWidget {
  const _RsvpOrnament();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 65,
          height: 1,
          color: const Color(0xFFD1B16E),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(
            Icons.auto_awesome,
            size: 24,
            color: Color(0xFFC49A45),
          ),
        ),

        Container(
          width: 65,
          height: 1,
          color: const Color(0xFFD1B16E),
        ),
      ],
    );
  }
}