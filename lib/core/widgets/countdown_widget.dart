import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CountdownWidget extends StatefulWidget {
  final DateTime eventDate;
  final bool princessTheme;

  const CountdownWidget({
    super.key,
    required this.eventDate,
    this.princessTheme = false,
  });

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();

    _calculateRemaining();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (_) => _calculateRemaining(),
    );
  }

  void _calculateRemaining() {
    final now = DateTime.now();
    final difference = widget.eventDate.difference(now);

    if (!mounted) return;

    setState(() {
      _remaining = difference.isNegative ? Duration.zero : difference;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;

    return widget.princessTheme
        ? _buildPrincessCountdown(
      context,
      days,
      hours,
      minutes,
      seconds,
    )
        : _buildDefaultCountdown(
      context,
      days,
      hours,
      minutes,
      seconds,
    );
  }

  // ============================
  // DISEÑO ORIGINAL
  // ============================

  Widget _buildDefaultCountdown(
      BuildContext context,
      int days,
      int hours,
      int minutes,
      int seconds,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Text(
            "FALTAN",
            style: GoogleFonts.montserrat(
              fontSize: 16,
              letterSpacing: 4,
              color: const Color(0xFF8C7B75),
            ),
          ),

          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _defaultTimeBox(days, "DÍAS"),
              _defaultTimeBox(hours, "HORAS"),
              _defaultTimeBox(minutes, "MIN"),
              _defaultTimeBox(seconds, "SEG"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _defaultTimeBox(int value, String label) {
    return Container(
      width: 70,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value.toString().padLeft(2, '0'),
            style: GoogleFonts.playfairDisplay(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3A2726),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 11,
              letterSpacing: 2,
              color: const Color(0xFF8C7B75),
            ),
          ),
        ],
      ),
    );
  }

  // ============================
  // TEMA PRINCESA
  // ============================

  Widget _buildPrincessCountdown(
      BuildContext context,
      int days,
      int hours,
      int minutes,
      int seconds,
      ) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 40,
      ),
      child: Column(
        children: [
          Text(
            'CUENTA REGRESIVA',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 4,
              color: const Color(0xFFC69A4A),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'FALTAN',
            style: GoogleFonts.playfairDisplay(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF9D5865),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            '✦  🦋  ✦',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFC69A4A),
            ),
          ),

          const SizedBox(height: 30),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: width < 400 ? 8 : 12,
            runSpacing: 12,
            children: [
              _princessTimeBox(days, 'DÍAS'),
              _princessTimeBox(hours, 'HORAS'),
              _princessTimeBox(minutes, 'MIN'),
              _princessTimeBox(seconds, 'SEG'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _princessTimeBox(int value, String label) {
    return Container(
      width: 76,
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8ECEE),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFD9A0AA).withOpacity(.55),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9D5865).withOpacity(.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value.toString().padLeft(2, '0'),
            style: GoogleFonts.playfairDisplay(
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF9D5865),
            ),
          ),

          const SizedBox(height: 6),

          Container(
            width: 28,
            height: 1,
            color: const Color(0xFFC69A4A).withOpacity(.6),
          ),

          const SizedBox(height: 7),

          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
              color: const Color(0xFF9D5865).withOpacity(.75),
            ),
          ),
        ],
      ),
    );
  }
}