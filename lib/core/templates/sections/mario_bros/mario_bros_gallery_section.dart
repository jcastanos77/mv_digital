import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MarioBrosGallerySection extends StatelessWidget {
  final List<String> images;

  const MarioBrosGallerySection({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      color: const Color(0xFFFFF8E7),
      child: Stack(
        children: [
          // ─────────────────────────────────────────
          // DECORACIÓN
          // ─────────────────────────────────────────

          const Positioned(
            top: 45,
            left: 18,
            child: _Cloud(scale: .45),
          ),

          const Positioned(
            top: 120,
            right: 10,
            child: _Cloud(scale: .55),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 72,
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
                      'NIVEL COMPLETADO',
                      style: GoogleFonts.baloo2(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.8,
                        color: const Color(0xFFE3262E),
                      ),
                    ),

                    const SizedBox(width: 12),

                    const _PixelLine(),
                  ],
                ),

                const SizedBox(height: 14),

                Text(
                  'MOMENTOS DE LA AVENTURA',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.baloo2(
                    fontSize: 28,
                    height: 1,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF263238),
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Algunos recuerdos que queremos compartir contigo',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.baloo2(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF68757A),
                  ),
                ),

                const SizedBox(height: 38),

                // ─────────────────────────────────────
                // GALERÍA
                // ─────────────────────────────────────

                LayoutBuilder(
                  builder: (context, constraints) {
                    final isDesktop = constraints.maxWidth > 700;

                    if (isDesktop) {
                      return _DesktopGallery(
                        images: images,
                      );
                    }

                    return _MobileGallery(
                      images: images,
                    );
                  },
                ),

                const SizedBox(height: 35),

                // ─────────────────────────────────────
                // ESTRELLAS
                // ─────────────────────────────────────

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 18,
                      color: Color(0xFFFFD83D),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '¡MÁS MOMENTOS POR VENIR!',
                      style: GoogleFonts.baloo2(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                        color: const Color(0xFF2E9B39),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.star_rounded,
                      size: 18,
                      color: Color(0xFFFFD83D),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ─────────────────────────────────────────
          // SUELO
          // ─────────────────────────────────────────

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
// MOBILE
// ═══════════════════════════════════════════════════════

class _MobileGallery extends StatelessWidget {
  final List<String> images;

  const _MobileGallery({
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < images.length; i++) ...[
          _GalleryCard(
            image: images[i],
            index: i,
            height: i == 0 ? 330 : 230,
          ),
          if (i != images.length - 1)
            const SizedBox(height: 16),
        ],
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════
// DESKTOP
// ═══════════════════════════════════════════════════════

class _DesktopGallery extends StatelessWidget {
  final List<String> images;

  const _DesktopGallery({
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        for (int i = 0; i < images.length; i++)
          _GalleryCard(
            image: images[i],
            index: i,
            width: 280,
            height: i == 0 ? 360 : 260,
          ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════
// GALLERY CARD
// ═══════════════════════════════════════════════════════

class _GalleryCard extends StatelessWidget {
  final String image;
  final int index;
  final double? width;
  final double height;

  const _GalleryCard({
    required this.image,
    required this.index,
    required this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showImage(context);
      },
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: index.isEven
                ? const Color(0xFFE3262E)
                : const Color(0xFFFFD83D),
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.10),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.all(7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(11),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                image,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.medium,
                errorBuilder: (_, __, ___) {
                  return Container(
                    color: const Color(0xFFEAF7FC),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      size: 40,
                      color: Color(0xFF8CA1AA),
                    ),
                  );
                },
              ),

              // Overlay muy sutil
              Positioned(
                right: 10,
                bottom: 10,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.45),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.zoom_in_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImage(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(.92),
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(14),
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  minScale: .8,
                  maxScale: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.55),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
                  color: Colors.white.withOpacity(.9),
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
                  color: Colors.white.withOpacity(.9),
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
                  color: Colors.white.withOpacity(.9),
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
      width: 30,
      height: 4,
      color: const Color(0xFFE3262E),
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
                  (_) {
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