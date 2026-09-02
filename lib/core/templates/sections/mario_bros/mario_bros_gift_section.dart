import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MarioBrosGiftSection extends StatelessWidget {
  final String title;
  final String description;

  const MarioBrosGiftSection({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF5ACAF2),
      child: Stack(
        children: [
          // ─────────────────────────────────────────────
          // NUBES
          // ─────────────────────────────────────────────

          const Positioned(
            top: 35,
            left: 15,
            child: _Cloud(
              scale: .55,
            ),
          ),

          const Positioned(
            top: 110,
            right: 10,
            child: _Cloud(
              scale: .45,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 75,
            ),
            child: Column(
              children: [
                // ─────────────────────────────────────
                // HEADER
                // ─────────────────────────────────────

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _PixelLine(),

                    const SizedBox(width: 12),

                    Text(
                      'POWER-UP',
                      style: GoogleFonts.baloo2(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const _PixelLine(),
                  ],
                ),

                const SizedBox(height: 14),

                Text(
                  '¿QUIERES DARME\nUN POWER-UP?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.baloo2(
                    fontSize: 31,
                    height: .95,
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

                const SizedBox(height: 38),

                // ─────────────────────────────────────
                // BLOQUE ?
                // ─────────────────────────────────────

                const _QuestionBlock(),

                const SizedBox(height: 28),

                // ─────────────────────────────────────
                // TARJETA
                // ─────────────────────────────────────

                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(
                    maxWidth: 430,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 30,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFFFFD83D),
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF287BB2).withOpacity(.20),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // ICONO
                      Container(
                        width: 62,
                        height: 62,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3C4),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFFFD83D),
                            width: 3,
                          ),
                        ),
                        child: const Icon(
                          Icons.card_giftcard_rounded,
                          color: Color(0xFFE3262E),
                          size: 31,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        title.isEmpty
                            ? 'Tu presencia es mi mejor regalo, pero si deseas tener un detalle...'
                            : title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.baloo2(
                          fontSize: 24,
                          height: 1.05,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF263238),
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _GiftOption(
                            icon: Icons.card_giftcard_rounded,
                            label: 'REGALO',
                          ),
                          const SizedBox(width: 28),
                          _GiftOption(
                            icon: Icons.payments_rounded,
                            label: 'EFECTIVO',
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // ORNAMENTO
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 45,
                            height: 3,
                            color: const Color(0xFFE3262E),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.star_rounded,
                            size: 18,
                            color: Color(0xFFFFD83D),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 45,
                            height: 3,
                            color: const Color(0xFFE3262E),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      Text(
                        '¡Gracias por acompañarme\nen esta aventura!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.baloo2(
                          fontSize: 13,
                          height: 1.35,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2E9B39),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ─────────────────────────────────────────────
          // SUELO
          // ─────────────────────────────────────────────

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
// QUESTION BLOCK
// ═══════════════════════════════════════════════════════

class _QuestionBlock extends StatelessWidget {
  const _QuestionBlock();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: const Color(0xFFFFD83D),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE3A900),
          width: 5,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFC98E00),
            offset: Offset(0, 7),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        '?',
        style: GoogleFonts.baloo2(
          fontSize: 44,
          height: 1,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          shadows: const [
            Shadow(
              color: Color(0xFFE3A900),
              offset: Offset(2, 2),
              blurRadius: 0,
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// CLOUD
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
                  color: Colors.white.withOpacity(.88),
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
                  color: Colors.white.withOpacity(.88),
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
                  color: Colors.white.withOpacity(.88),
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
// PIXEL LINE
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
// PIXEL GROUND
// ═══════════════════════════════════════════════════════

class _PixelGround extends StatelessWidget {
  const _PixelGround();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 7,
          color: const Color(0xFF2E9B39),
        ),
        Container(
          height: 28,
          color: const Color(0xFF8A542E),
          child: Row(
            children: List.generate(
              12,
                  (index) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF633B22),
                        width: 1.5,
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

class _GiftOption extends StatelessWidget {
  final IconData icon;
  final String label;

  const _GiftOption({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3C4),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color(0xFFFFD83D),
              width: 3,
            ),
          ),
          child: Icon(
            icon,
            color: const Color(0xFFE3262E),
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.baloo2(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
            color: const Color(0xFF263238),
          ),
        ),
      ],
    );
  }
}