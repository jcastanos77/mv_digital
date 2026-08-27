import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonCountdown extends StatefulWidget {
  final DateTime eventDate;

  const PokemonCountdown({
    super.key,
    required this.eventDate,
  });

  @override
  State<PokemonCountdown> createState() => _PokemonCountdownState();
}

class _PokemonCountdownState extends State<PokemonCountdown> {
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
    final difference = widget.eventDate.difference(DateTime.now());

    final newRemaining = difference.isNegative
        ? Duration.zero
        : difference;

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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 45,
      ),
      color: const Color(0xFF0A1B3D),
      child: Column(
        children: [
          /// POKÉBOLA SUPERIOR
          const _MiniPokeBall(),

          const SizedBox(height: 14),

          /// TÍTULO
          Text(
            "¡LA AVENTURA COMIENZA EN!",
            textAlign: TextAlign.center,
            style: GoogleFonts.fredoka(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),

          const SizedBox(height: 10),

          /// DIVISOR
          Container(
            width: 70,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xFFFFCB05),
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          const SizedBox(height: 32),

          /// CONTADOR
          ValueListenableBuilder<Duration>(
            valueListenable: _remaining,
            builder: (context, remaining, child) {
              final days = remaining.inDays;
              final hours = remaining.inHours.remainder(24);
              final minutes = remaining.inMinutes.remainder(60);
              final seconds = remaining.inSeconds.remainder(60);

              return Row(
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
              );
            },
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
              horizontal: 8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1B356E),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFFFCB05),
                width: 2,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Text(
              value.toString().padLeft(2, "0"),
              textAlign: TextAlign.center,
              style: GoogleFonts.fredoka(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            label,
            style: GoogleFonts.fredoka(
              color: const Color(0xFFFFCB05),
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _separator() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 2,
        right: 2,
        bottom: 28,
      ),
      child: Text(
        ":",
        style: GoogleFonts.fredoka(
          color: const Color(0xFFFFCB05),
          fontSize: 28,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

/// MINI POKÉBOLA
class _MiniPokeBall extends StatelessWidget {
  const _MiniPokeBall();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// PARTE ROJA
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 19,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFE53935),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
            ),
          ),

          /// LÍNEA CENTRAL
          Container(
            width: double.infinity,
            height: 4,
            color: Colors.white,
          ),

          /// BOTÓN CENTRAL
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: const Color(0xFF0A1B3D),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}