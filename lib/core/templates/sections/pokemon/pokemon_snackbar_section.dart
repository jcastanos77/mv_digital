import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../models/snackBar_model.dart';

class PokemonSnackBarSection extends StatelessWidget {
  final SnackBarData? data;

  const PokemonSnackBarSection({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const SizedBox.shrink();
    }

    const yellow = Color(0xFFFFCB05);
    const red = Color(0xFFE53935);
    const blue = Color(0xFF1B356E);
    const background = Color(0xFF0A1B3D);

    return Container(
      width: double.infinity,
      color: background,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 55,
      ),
      child: Column(
        children: [
          /// ICONO
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: red,
              shape: BoxShape.circle,
              border: Border.all(
                color: yellow,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: red.withOpacity(.30),
                  blurRadius: 25,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: const Icon(
              Icons.fastfood_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),

          const SizedBox(height: 22),

          /// SUBTÍTULO
          Text(
            "RECARGA ENERGÍA PARA LA AVENTURA",
            textAlign: TextAlign.center,
            style: GoogleFonts.fredoka(
              color: Colors.white60,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: 8),

          /// TÍTULO
          Text(
            data!.title.isEmpty
                ? "POKÉ SNACKS"
                : data!.title.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.fredoka(
              color: yellow,
              fontSize: 36,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: 18),

          /// DESCRIPCIÓN
          if (data!.subtitle.isNotEmpty)
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: Text(
                data!.subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.fredoka(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.7,
                ),
              ),
            ),

          const SizedBox(height: 30),

          /// HORARIO
          if (data!.startTime.isNotEmpty ||
              data!.endTime.isNotEmpty)
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(
                maxWidth: 420,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 22,
              ),
              decoration: BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: yellow,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.25),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.bolt_rounded,
                    color: yellow,
                    size: 32,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "HORARIO DE RECARGA",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.fredoka(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      _time(
                        title: "INICIO",
                        value: data!.startTime,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Container(
                          width: 30,
                          height: 3,
                          decoration: BoxDecoration(
                            color: yellow,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),

                      _time(
                        title: "FIN",
                        value: data!.endTime,
                      ),
                    ],
                  ),
                ],
              ),
            ),

          const SizedBox(height: 35),

          /// DECORACIÓN FINAL
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _line(),

              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 14,
                ),
                child: _SnackPokeBall(),
              ),

              _line(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _time({
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.fredoka(
            color: Colors.white54,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          value.isEmpty ? "--" : value,
          style: GoogleFonts.fredoka(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _line() {
    return Container(
      width: 50,
      height: 2,
      color: Colors.white24,
    );
  }
}

class _SnackPokeBall extends StatelessWidget {
  const _SnackPokeBall();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 12,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFE53935),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
            ),
          ),

          Container(
            width: double.infinity,
            height: 3,
            color: Colors.white,
          ),

          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: const Color(0xFF0A1B3D),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}