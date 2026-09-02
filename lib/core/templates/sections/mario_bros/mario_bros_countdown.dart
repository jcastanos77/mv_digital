import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MarioBrosCountdown extends StatefulWidget {
  final DateTime eventDate;

  const MarioBrosCountdown({
    super.key,
    required this.eventDate,
  });

  @override
  State<MarioBrosCountdown> createState() => _MarioBrosCountdownState();
}

class _MarioBrosCountdownState extends State<MarioBrosCountdown> {
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
    final difference = widget.eventDate.difference(DateTime.now());

    if (!mounted) return;

    setState(() {
      _remaining = difference.isNegative ? Duration.zero : difference;
    });
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
      color: const Color(0xFF5ACAF2),
      child: Stack(
        children: [
          const Positioned(
            top: 35,
            left: 20,
            child: _Cloud(
              scale: .65,
            ),
          ),
          const Positioned(
            top: 95,
            right: 10,
            child: _Cloud(
              scale: .5,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 70,
            ),
            child: Column(
              children: [
                // ─────────────────────────────────────
                // ETIQUETA
                // ─────────────────────────────────────

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _PixelLine(),
                    const SizedBox(width: 12),
                    Text(
                      'NUEVA AVENTURA',
                      style: GoogleFonts.baloo2(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        color: const Color(0xFFFFFFFF),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const _PixelLine(),
                  ],
                ),

                const SizedBox(height: 14),

                Text(
                  '¡LA FIESTA COMIENZA EN...',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.baloo2(
                    fontSize: 28,
                    height: 1,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    shadows: const [
                      Shadow(
                        color: Color(0xFF287BB2),
                        offset: Offset(2, 3),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 42),

                // ─────────────────────────────────────
                // CONTADOR
                // ─────────────────────────────────────

                LayoutBuilder(
                  builder: (context, constraints) {
                    final isSmall = constraints.maxWidth < 380;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _TimeBox(
                          value: days,
                          label: 'DÍAS',
                          width: isSmall ? 68 : 78,
                        ),
                        const _TimeSeparator(),
                        _TimeBox(
                          value: hours,
                          label: 'HORAS',
                          width: isSmall ? 68 : 78,
                        ),
                        const _TimeSeparator(),
                        _TimeBox(
                          value: minutes,
                          label: 'MIN',
                          width: isSmall ? 68 : 78,
                        ),
                        const _TimeSeparator(),
                        _TimeBox(
                          value: seconds,
                          label: 'SEG',
                          width: isSmall ? 68 : 78,
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 48),

                // ─────────────────────────────────────
                // MONEDA CENTRAL
                // ─────────────────────────────────────

                const _Coin(),

                const SizedBox(height: 30),

                Text(
                  '¡PREPÁRATE PARA LA AVENTURA!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.baloo2(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    color: Colors.white,
                    shadows: const [
                      Shadow(
                        color: Color(0xFF287BB2),
                        offset: Offset(1, 2),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ───────────────────────────────────────────
          // SUELO
          // ───────────────────────────────────────────

          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _PixelGround(),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// TIME BOX
// ═══════════════════════════════════════════════════════

class _TimeBox extends StatelessWidget {
  final int value;
  final String label;
  final double width;

  const _TimeBox({
    required this.value,
    required this.label,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          Container(
            width: width,
            height: 76,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFFFD83D),
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF287BB2).withOpacity(.25),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              value.toString().padLeft(2, '0'),
              style: GoogleFonts.baloo2(
                fontSize: 31,
                height: 1,
                fontWeight: FontWeight.w900,
                color: const Color(0xFFE3262E),
              ),
            ),
          ),
          const SizedBox(height: 9),
          Text(
            label,
            style: GoogleFonts.baloo2(
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// SEPARADOR
// ═══════════════════════════════════════════════════════

class _TimeSeparator extends StatelessWidget {
  const _TimeSeparator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 25,
        left: 4,
        right: 4,
      ),
      child: Text(
        ':',
        style: GoogleFonts.baloo2(
          fontSize: 25,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// MONEDA
// ═══════════════════════════════════════════════════════

class _Coin extends StatelessWidget {
  const _Coin();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFFFD83D),
        border: Border.all(
          color: const Color(0xFFF0A800),
          width: 5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '\$',
          style: GoogleFonts.baloo2(
            fontSize: 29,
            fontWeight: FontWeight.w900,
            color: const Color(0xFFF0A800),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// NUBE
// ═══════════════════════════════════════════════════════

class _Cloud extends StatelessWidget {
  final double scale;

  const _Cloud({
    this.scale = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: SizedBox(
        width: 115,
        height: 55,
        child: Stack(
          children: [
            Positioned(
              left: 10,
              bottom: 5,
              child: Container(
                width: 95,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.92),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: 4,
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.92),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: 55,
              top: 12,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.92),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// LÍNEA PIXEL
// ═══════════════════════════════════════════════════════

class _PixelLine extends StatelessWidget {
  const _PixelLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 4,
      color: const Color(0xFFFFD83D),
    );
  }
}

// ═══════════════════════════════════════════════════════
// SUELO PIXEL
// ═══════════════════════════════════════════════════════

class _PixelGround extends StatelessWidget {
  const _PixelGround();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 8,
          color: const Color(0xFF2E9B39),
        ),
        Container(
          height: 34,
          decoration: const BoxDecoration(
            color: Color(0xFF8A542E),
          ),
          child: Row(
            children: List.generate(
              12,
                  (index) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF633B22),
                        width: 2,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}