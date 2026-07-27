import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../models/snackBar_model.dart';

class SpidermanSnackBarSection extends StatelessWidget {
  final SnackBarData? data;

  const SpidermanSnackBarSection({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const SizedBox.shrink();
    }

    const red = Color(0xFFE62429);
    const blue = Color(0xFF102A4C);
    const background = Color(0xFF071426);

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
                color: Colors.white,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: red.withOpacity(.25),
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
            "RECARGA TUS PODERES",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.white60,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 3,
            ),
          ),

          const SizedBox(height: 8),

          /// TÍTULO
          Text(
            data!.title.isEmpty
                ? "ESTACIÓN DE SNACKS"
                : data!.title.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.bangers(
              color: red,
              fontSize: 38,
              letterSpacing: 3,
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
                style: GoogleFonts.montserrat(
                  color: Colors.white70,
                  fontSize: 14,
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
                  color: red,
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
                    Icons.access_time_rounded,
                    color: red,
                    size: 30,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "HORARIO DE LA ESTACIÓN",
                    style: GoogleFonts.bangers(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      _time(
                        title: "INICIO",
                        value: data!.startTime,
                      ),

                      Padding(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Container(
                          width: 30,
                          height: 2,
                          color: red,
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

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                ),
                child: Text(
                  "POW!",
                  style: GoogleFonts.bangers(
                    color: red,
                    fontSize: 24,
                    letterSpacing: 2,
                  ),
                ),
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
          style: GoogleFonts.montserrat(
            color: Colors.white54,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          value.isEmpty ? "--" : value,
          style: GoogleFonts.bangers(
            color: Colors.white,
            fontSize: 24,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _line() {
    return Container(
      width: 45,
      height: 2,
      color: Colors.white24,
    );
  }
}