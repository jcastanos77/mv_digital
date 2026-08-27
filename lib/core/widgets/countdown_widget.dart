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
  Timer? _timer;

  final ValueNotifier<Duration> _remaining =
  ValueNotifier(Duration.zero);

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
    final difference =
    widget.eventDate.difference(DateTime.now());

    final newRemaining =
    difference.isNegative ? Duration.zero : difference;

    if (_remaining.value != newRemaining) {
      _remaining.value = newRemaining;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _remaining.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.princessTheme
        ? _buildPrincessCountdown()
        : _buildDefaultCountdown();
  }

  // ============================
  // DISEÑO ORIGINAL
  // ============================

  Widget _buildDefaultCountdown() {
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

          ValueListenableBuilder<Duration>(
            valueListenable: _remaining,
            builder: (context, remaining, child) {
              final days = remaining.inDays;
              final hours =
              remaining.inHours.remainder(24);
              final minutes =
              remaining.inMinutes.remainder(60);
              final seconds =
              remaining.inSeconds.remainder(60);

              return Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: [
                  _defaultTimeBox(days, "DÍAS"),
                  _defaultTimeBox(hours, "HORAS"),
                  _defaultTimeBox(minutes, "MIN"),
                  _defaultTimeBox(seconds, "SEG"),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _defaultTimeBox(
      int value,
      String label,
      ) {
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

  Widget _buildPrincessCountdown() {
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

          ValueListenableBuilder<Duration>(
            valueListenable: _remaining,
            builder: (context, remaining, child) {
              final days = remaining.inDays;
              final hours =
              remaining.inHours.remainder(24);
              final minutes =
              remaining.inMinutes.remainder(60);
              final seconds =
              remaining.inSeconds.remainder(60);

              return LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

                  return Wrap(
                    alignment: WrapAlignment.center,
                    spacing: width < 400 ? 8 : 12,
                    runSpacing: 12,
                    children: [
                      _princessTimeBox(days, 'DÍAS'),
                      _princessTimeBox(hours, 'HORAS'),
                      _princessTimeBox(minutes, 'MIN'),
                      _princessTimeBox(seconds, 'SEG'),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _princessTimeBox(
      int value,
      String label,
      ) {
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
            color: const Color(0xFF9D5865)
                .withOpacity(.08),
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
            color: const Color(0xFFC69A4A)
                .withOpacity(.6),
          ),

          const SizedBox(height: 7),

          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
              color: const Color(0xFF9D5865)
                  .withOpacity(.75),
            ),
          ),
        ],
      ),
    );
  }
}