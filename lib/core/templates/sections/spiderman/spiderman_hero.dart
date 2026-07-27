import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SpidermanHero extends StatelessWidget {
  final String title;
  final String heroImage;
  final DateTime eventDate;

  const SpidermanHero({
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

          /// OSCURECER FOTO
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, .45, 1],
                  colors: [
                    Color.fromRGBO(3, 12, 25, .20),
                    Color.fromRGBO(3, 12, 25, .30),
                    Color.fromRGBO(3, 12, 25, .92),
                  ],
                ),
              ),
            ),
          ),

          /// DECORACIÓN SUPERIOR
          Positioned(
            top: 45,
            left: -45,
            child: _webCircle(),
          ),

          Positioned(
            top: 110,
            right: -60,
            child: _webCircle(),
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
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE62429),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Text(
                        "¡ESTÁS INVITADO!",
                        style: GoogleFonts.bangers(
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 2,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      "A MI CUMPLEAÑOS",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bangers(
                        color: Colors.white,
                        fontSize: 27,
                        letterSpacing: 3,
                        shadows: const [
                          Shadow(
                            color: Colors.black54,
                            blurRadius: 8,
                            offset: Offset(2, 3),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 4),

                    /// NOMBRE
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        title.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bangers(
                          color: const Color(0xFFE62429),
                          fontSize: 76,
                          letterSpacing: 3,
                          shadows: const [
                            Shadow(
                              color: Colors.white,
                              blurRadius: 1,
                              offset: Offset(2, 0),
                            ),
                            Shadow(
                              color: Colors.black,
                              blurRadius: 0,
                              offset: Offset(4, 5),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    /// DIVISOR
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 45,
                          height: 2,
                          color: Colors.white54,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(
                            Icons.bolt,
                            color: Color(0xFFE62429),
                            size: 22,
                          ),
                        ),
                        Container(
                          width: 45,
                          height: 2,
                          color: Colors.white54,
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    /// FECHA
                    Text(
                      DateFormat(
                        "dd • MM • yyyy",
                      ).format(eventDate),
                      style: GoogleFonts.bangers(
                        color: Colors.white,
                        fontSize: 23,
                        letterSpacing: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// TRANSICIÓN AL RESTO DEL TEMPLATE
          Positioned(
            left: 0,
            right: 0,
            bottom: -1,
            child: Container(
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xFF071426),
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

  Widget _webCircle() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(.12),
          width: 2,
        ),
      ),
      child: Center(
        child: Container(
          width: 95,
          height: 95,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(.10),
              width: 2,
            ),
          ),
          child: Center(
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(.08),
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}