import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeddingCountdownSection extends StatefulWidget {

  final DateTime eventDate;

  const WeddingCountdownSection({
    super.key,
    required this.eventDate,
  });

  @override
  State<WeddingCountdownSection> createState() =>
      _WeddingCountdownSectionState();
}

class _WeddingCountdownSectionState
    extends State<WeddingCountdownSection> {

  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();

    _updateTime();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateTime();
    });
  }

  void _updateTime() {

    final now = DateTime.now();

    final difference = widget.eventDate.difference(now);

    setState(() {
      _remaining = difference.isNegative
          ? Duration.zero
          : difference;
    });

  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    const champagne = Color(0xFFB08A5B);
    const background = Color(0xFFF7F5F2);

    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;

    return Container(
      color: background,
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Center(
        child: Column(
          children: [

            Container(
              width: 80,
              height: 1,
              color: champagne.withOpacity(0.7),
            ),

            const SizedBox(height: 30),

            Text(
              "FALTAN",
              style: GoogleFonts.montserrat(
                fontSize: 12,
                letterSpacing: 6,
                color: champagne,
              ),
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                _TimeBlock(value: days.toString(), label: "DÍAS"),

                const SizedBox(width: 40),

                _TimeBlock(
                    value: hours.toString().padLeft(2, '0'),
                    label: "HORAS"
                ),

                const SizedBox(width: 40),

                _TimeBlock(
                    value: minutes.toString().padLeft(2, '0'),
                    label: "MIN"
                ),

                const SizedBox(width: 40),

                _TimeBlock(
                    value: seconds.toString().padLeft(2, '0'),
                    label: "SEG"
                ),
              ],
            ),

            const SizedBox(height: 40),

            Container(
              width: 80,
              height: 1,
              color: champagne.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }
}
class _TimeBlock extends StatelessWidget {
  final String value;
  final String label;

  const _TimeBlock({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: Text(
            value,
            key: ValueKey(value),
            style: GoogleFonts.playfairDisplay(
              fontSize: 48,
              color: Color(0xFF1F1F1F),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 11,
            letterSpacing: 4,
            color: Color(0xFF1F1F1F),
          ),
        ),
      ],
    );
  }
}