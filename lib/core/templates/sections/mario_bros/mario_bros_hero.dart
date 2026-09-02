import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MarioBrosHero extends StatelessWidget {
  final String title;
  final String heroImage;
  final DateTime eventDate;

  const MarioBrosHero({
    super.key,
    required this.title,
    required this.heroImage,
    required this.eventDate,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat(
      "d 'DE' MMMM",
      'es',
    ).format(eventDate).toUpperCase();

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .88,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ─────────────────────────────────────────────
          // FONDO
          // ─────────────────────────────────────────────
          if (heroImage.isNotEmpty)
            Image.network(
              heroImage,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.medium,
              errorBuilder: (_, __, ___) {
                return const _MarioSkyBackground();
              },
            )
          else
            const _MarioSkyBackground(),

          // ─────────────────────────────────────────────
          // OVERLAY PARA DAR PROFUNDIDAD
          // ─────────────────────────────────────────────
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(.05),
                  Colors.black.withOpacity(.08),
                  Colors.black.withOpacity(.25),
                  Colors.black.withOpacity(.65),
                ],
                stops: const [
                  0,
                  .35,
                  .65,
                  1,
                ],
              ),
            ),
          ),

          // ─────────────────────────────────────────────
          // CONTENIDO
          // ─────────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 34,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Spacer(),

                  // INVITACIÓN
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD83D),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.25),
                          blurRadius: 12,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Text(
                      '¡ESTÁS INVITADO!',
                      style: GoogleFonts.baloo2(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        color: const Color(0xFFB51F2A),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // NOMBRE
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.baloo2(
                      fontSize: 48,
                      height: .95,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      shadows: [
                        const Shadow(
                          color: Color(0xFFB51F2A),
                          offset: Offset(3, 4),
                          blurRadius: 0,
                        ),
                        Shadow(
                          color: Colors.black.withOpacity(.35),
                          offset: const Offset(0, 5),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  // EDAD / CUMPLE
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const _PixelLine(),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Text(
                          '¡MI CUMPLE!',
                          style: GoogleFonts.baloo2(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                            color: Colors.white,
                            shadows: const [
                              Shadow(
                                color: Colors.black54,
                                offset: Offset(1, 2),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const _PixelLine(),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // FECHA
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 11,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFFFD83D),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.25),
                          blurRadius: 12,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Text(
                      formattedDate,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.baloo2(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                        color: const Color(0xFF2D6CDF),
                      ),
                    ),
                  ),

                  const SizedBox(height: 34),

                  // INDICADOR DE SCROLL
                  Column(
                    children: [
                      Text(
                        'DESLIZA PARA CONTINUAR',
                        style: GoogleFonts.baloo2(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.8,
                          color: Colors.white.withOpacity(.85),
                        ),
                      ),
                      const SizedBox(height: 7),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white.withOpacity(.9),
                        size: 27,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// FONDO FALLBACK
// ═══════════════════════════════════════════════════════

class _MarioSkyBackground extends StatelessWidget {
  const _MarioSkyBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF55C9F4),
            Color(0xFF9BE4F8),
            Color(0xFFE9F8FF),
          ],
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            top: 90,
            left: 25,
            child: _Cloud(),
          ),
          const Positioned(
            top: 180,
            right: 30,
            child: _Cloud(scale: .75),
          ),
          const Positioned(
            top: 330,
            left: 70,
            child: _Cloud(scale: .55),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 90,
              decoration: const BoxDecoration(
                color: Color(0xFF56B947),
                border: Border(
                  top: BorderSide(
                    color: Color(0xFF2D8B35),
                    width: 7,
                  ),
                ),
              ),
            ),
          ),
        ],
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
                  color: Colors.white.withOpacity(.95),
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
                  color: Colors.white.withOpacity(.95),
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
                  color: Colors.white.withOpacity(.95),
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
      width: 35,
      height: 4,
      decoration: const BoxDecoration(
        color: Color(0xFFFFD83D),
      ),
    );
  }
}