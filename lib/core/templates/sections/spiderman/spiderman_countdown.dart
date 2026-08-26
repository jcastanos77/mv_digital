import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpidermanCountdown extends StatefulWidget {
  final DateTime eventDate;

  const SpidermanCountdown({
    super.key,
    required this.eventDate,
  });

  @override
  State<SpidermanCountdown> createState() =>
      _SpidermanCountdownState();
}

class _SpidermanCountdownState extends State<SpidermanCountdown> {
  Timer? _timer;
  Duration remaining = Duration.zero;

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
    final difference = widget.eventDate.difference(DateTime.now());

    if (!mounted) return;

    setState(() {
      remaining = difference.isNegative
          ? Duration.zero
          : difference;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = remaining.inDays;
    final hours = remaining.inHours.remainder(24);
    final minutes = remaining.inMinutes.remainder(60);
    final seconds = remaining.inSeconds.remainder(60);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 45,
      ),
      color: const Color(0xFF071426),
      child: Column(
        children: [
          Text(
            "¡LA MISIÓN COMIENZA EN!",
            textAlign: TextAlign.center,
            style: GoogleFonts.bangers(
              color: Colors.white,
              fontSize: 26,
              letterSpacing: 3,
            ),
          ),

          const SizedBox(height: 8),

          Container(
            width: 55,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE62429),
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          const SizedBox(height: 32),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _timeBox(
                value: days,
                label: "DÍAS",
              ),

              _separator(),

              _timeBox(
                value: hours,
                label: "HRS",
              ),

              _separator(),

              _timeBox(
                value: minutes,
                label: "MIN",
              ),

              _separator(),

              _timeBox(
                value: seconds,
                label: "SEG",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _timeBox({
    required int value,
    required String label,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(
              maxWidth: 85,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF102A4C),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFE62429),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.25),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Text(
              value.toString().padLeft(2, "0"),
              textAlign: TextAlign.center,
              style: GoogleFonts.bangers(
                color: Colors.white,
                fontSize: 32,
                letterSpacing: 1,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            label,
            style: GoogleFonts.montserrat(
              color: Colors.white60,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _separator() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 3,
        right: 3,
        bottom: 27,
      ),
      child: Text(
        ":",
        style: GoogleFonts.bangers(
          color: const Color(0xFFE62429),
          fontSize: 28,
        ),
      ),
    );
  }
}