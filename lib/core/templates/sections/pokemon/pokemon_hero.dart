import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../widgets/scroll_indicator.dart';

class PokemonHero extends StatelessWidget {
  final String title;
  final String heroImage;
  final DateTime eventDate;

  const PokemonHero({
    super.key,
    required this.title,
    required this.heroImage,
    required this.eventDate,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 720,
      child: Stack(
        children: [
          /// FOTO
          Positioned.fill(
            child: Image.network(
              heroImage,
              fit: BoxFit.cover,
              gaplessPlayback: true,
              filterQuality: FilterQuality.medium,
            ),
          ),

          /// OVERLAY
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, .45, 1],
                  colors: [
                    Color.fromRGBO(7, 26, 61, .15),
                    Color.fromRGBO(7, 26, 61, .35),
                    Color.fromRGBO(7, 26, 61, .95),
                  ],
                ),
              ),
            ),
          ),

          /// POKÉBOLA DECORATIVA SUPERIOR
          const Positioned(
            top: -70,
            left: -70,
            child: _PokemonBall(
              size: 190,
              opacity: .18,
            ),
          ),

          /// POKÉBOLA DECORATIVA LATERAL
          const Positioned(
            top: 100,
            right: -75,
            child: _PokemonBall(
              size: 170,
              opacity: .12,
            ),
          ),

          /// DESTELLOS
          const Positioned(
            top: 180,
            left: 25,
            child: Icon(
              Icons.auto_awesome,
              color: Color(0xFFFFCB05),
              size: 22,
            ),
          ),

          const Positioned(
            top: 290,
            right: 30,
            child: Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 18,
            ),
          ),

          /// CONTENIDO
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  40,
                  24,
                  75,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// ETIQUETA
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFCB05),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withOpacity(.65),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.30),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Text(
                        "¡TE ELIJO PARA MI FIESTA!",
                        style: GoogleFonts.fredoka(
                          color: const Color(0xFF1B356E),
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    /// TÍTULO
                    Text(
                      "ENTRENADOR INVITADO A CELEBRAR",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.fredoka(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                        shadows: const [
                          Shadow(
                            color: Colors.black54,
                            blurRadius: 8,
                            offset: Offset(2, 3),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// NOMBRE
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        title.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.fredoka(
                          color: const Color(0xFFFFCB05),
                          fontSize: 72,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                          shadows: const [
                            Shadow(
                              color: Color(0xFF1B356E),
                              blurRadius: 0,
                              offset: Offset(3, 3),
                            ),
                            Shadow(
                              color: Colors.black,
                              blurRadius: 2,
                              offset: Offset(5, 6),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// DIVISOR
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 2,
                          color: Colors.white54,
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14,
                          ),
                          child: _MiniPokemonBall(),
                        ),

                        Container(
                          width: 50,
                          height: 2,
                          color: Colors.white54,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// FECHA
                    Text(
                      DateFormat(
                        "dd • MM • yyyy",
                      ).format(eventDate),
                      style: GoogleFonts.fredoka(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3,
                      ),
                    ),

                    const SizedBox(height: 35),

                    const ScrollIndicator(),
                  ],
                ),
              ),
            ),
          ),

          /// TRANSICIÓN
          Positioned(
            left: 0,
            right: 0,
            bottom: -1,
            child: Container(
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xFF0A1B3D),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// POKÉBOLA DECORATIVA GRANDE
class _PokemonBall extends StatelessWidget {
  final double size;
  final double opacity;

  const _PokemonBall({
    required this.size,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 7,
          ),
        ),
        child: Stack(
          children: [
            /// MITAD SUPERIOR
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: size / 2,
                decoration: const BoxDecoration(
                  color: Color(0xFFE53935),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(200),
                  ),
                ),
              ),
            ),

            /// LÍNEA CENTRAL
            Positioned(
              left: 0,
              right: 0,
              top: (size / 2) - 4,
              child: Container(
                height: 8,
                color: Colors.white,
              ),
            ),

            /// CENTRO
            Center(
              child: Container(
                width: size * .28,
                height: size * .28,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF1A1A1A),
                    width: 6,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: size * .12,
                    height: size * .12,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1A1A1A),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// MINI POKÉBOLA DEL DIVISOR
class _MiniPokemonBall extends StatelessWidget {
  const _MiniPokemonBall();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 26,
      height: 26,
      child: CustomPaint(
        painter: _MiniPokemonBallPainter(),
      ),
    );
  }
}

class _MiniPokemonBallPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius = size.width / 2;

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final redPaint = Paint()
      ..color = const Color(0xFFE53935)
      ..style = PaintingStyle.fill;

    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    /// CÍRCULO
    canvas.drawCircle(
      center,
      radius - 1,
      whitePaint,
    );

    /// MITAD ROJA
    final path = Path()
      ..addArc(
        Rect.fromCircle(
          center: center,
          radius: radius - 1,
        ),
        3.1416,
        3.1416,
      )
      ..close();

    canvas.drawPath(
      path,
      redPaint,
    );

    /// LÍNEA
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      borderPaint,
    );

    /// CENTRO
    canvas.drawCircle(
      center,
      5,
      whitePaint,
    );

    canvas.drawCircle(
      center,
      5,
      borderPaint,
    );

    canvas.drawCircle(
      center,
      2,
      Paint()..color = const Color(0xFF1A1A1A),
    );

    /// BORDE
    canvas.drawCircle(
      center,
      radius - 1,
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(
      covariant CustomPainter oldDelegate,
      ) {
    return false;
  }
}