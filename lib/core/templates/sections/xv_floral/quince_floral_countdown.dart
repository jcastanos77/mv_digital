import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuinceFloralCountdown extends StatefulWidget {
  final DateTime eventDate;

  const QuinceFloralCountdown({
    super.key,
    required this.eventDate,
  });

  @override
  State<QuinceFloralCountdown> createState() =>
      _QuinceFloralCountdownState();
}

class _QuinceFloralCountdownState extends State<QuinceFloralCountdown> {
  Timer? _timer;

  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();

    _updateCountdown();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (_) => _updateCountdown(),
    );
  }

  void _updateCountdown() {
    final difference =
    widget.eventDate.difference(DateTime.now());

    final remaining =
    difference.isNegative ? Duration.zero : difference;

    if (mounted) {
      setState(() {
        _remaining = remaining;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _remaining.inDays;
    final hours = _remaining.inHours.remainder(24);
    final minutes = _remaining.inMinutes.remainder(60);
    final seconds = _remaining.inSeconds.remainder(60);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 70,
      ),
      color: const Color(0xFFFFFCF8),
      child: Column(
        children: [
          Text(
            'CUENTA REGRESIVA',
            style: GoogleFonts.montserrat(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 4,
              color: const Color(0xFFC49A45),
            ),
          ),

          const SizedBox(height: 14),

          Text(
            'El gran día está por llegar',
            textAlign: TextAlign.center,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 26,
              fontStyle: FontStyle.italic,
              color: const Color(0xFF4A403A),
            ),
          ),

          const SizedBox(height: 25),

          _Ornament(),

          const SizedBox(height: 35),

          LayoutBuilder(
            builder: (context, constraints) {
              final isSmall = constraints.maxWidth < 390;

              return Wrap(
                alignment: WrapAlignment.center,
                spacing: isSmall ? 6 : 14,
                runSpacing: 16,
                children: [
                  _TimeBox(
                    value: days,
                    label: 'DÍAS',
                  ),
                  _TimeBox(
                    value: hours,
                    label: 'HORAS',
                  ),
                  _TimeBox(
                    value: minutes,
                    label: 'MIN',
                  ),
                  _TimeBox(
                    value: seconds,
                    label: 'SEG',
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 25),

          _Ornament(),
        ],
      ),
    );
  }
}

class _TimeBox extends StatelessWidget {
  final int value;
  final String label;

  const _TimeBox({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE8D8B8),
        ),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value.toString().padLeft(2, '0'),
            style: GoogleFonts.cormorantGaramond(
              fontSize: 42,
              height: .9,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFC49A45),
            ),
          ),

          const SizedBox(height: 12),

          Container(
            width: 28,
            height: 1,
            color: const Color(0xFFD1B16E),
          ),

          const SizedBox(height: 9),

          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 8,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
              color: const Color(0xFF6A5E54),
            ),
          ),
        ],
      ),
    );
  }
}

class _Ornament extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 55,
          height: 1,
          color: const Color(0xFFC49A45),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Icon(
            Icons.local_florist_outlined,
            size: 18,
            color: Color(0xFFC49A45),
          ),
        ),

        Container(
          width: 55,
          height: 1,
          color: const Color(0xFFC49A45),
        ),
      ],
    );
  }
}