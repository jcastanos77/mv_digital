import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonGallerySection extends StatelessWidget {
  final List<String> images;

  const PokemonGallerySection({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
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
        horizontal: 20,
        vertical: 50,
      ),
      child: Column(
        children: [
          /// TÍTULO
          Text(
            "MIS AVENTURAS",
            textAlign: TextAlign.center,
            style: GoogleFonts.fredoka(
              color: yellow,
              fontSize: 36,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "Algunos recuerdos de mi gran aventura",
            textAlign: TextAlign.center,
            style: GoogleFonts.fredoka(
              color: Colors.white60,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 14),

          /// DIVISOR
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 45,
                height: 3,
                color: yellow,
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: _GalleryPokeBall(),
              ),

              Container(
                width: 45,
                height: 3,
                color: yellow,
              ),
            ],
          ),

          const SizedBox(height: 35),

          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 700,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 500;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: images.length,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile ? 2 : 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 20,
                    childAspectRatio: .68,
                  ),
                  itemBuilder: (context, index) {
                    return _pokemonCard(
                      images[index],
                      index,
                      yellow,
                      red,
                      blue,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _pokemonCard(
      String image,
      int index,
      Color yellow,
      Color red,
      Color blue,
      ) {
    final cardColor = index % 3 == 0
        ? yellow
        : index % 3 == 1
        ? red
        : const Color(0xFF55C1FF);

    return Transform.rotate(
      angle: index.isEven ? -.02 : .02,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.white.withOpacity(.90),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.35),
              blurRadius: 14,
              offset: const Offset(4, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            /// HEADER DE LA CARTA
            Padding(
              padding: const EdgeInsets.fromLTRB(
                7,
                7,
                7,
                5,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.catching_pokemon_rounded,
                    color: Color(0xFF0A1B3D),
                    size: 16,
                  ),

                  const SizedBox(width: 4),

                  Expanded(
                    child: Text(
                      "MI AVENTURA",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.fredoka(
                        color: const Color(0xFF0A1B3D),
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  Text(
                    "★",
                    style: GoogleFonts.fredoka(
                      color: const Color(0xFF0A1B3D),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),

            /// IMAGEN
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                  filterQuality: FilterQuality.medium,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      color: blue,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.photo_outlined,
                        color: Colors.white54,
                        size: 40,
                      ),
                    );
                  },
                  loadingBuilder: (
                      context,
                      child,
                      loadingProgress,
                      ) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return Container(
                      color: blue,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: yellow,
                        strokeWidth: 2,
                      ),
                    );
                  },
                ),
              ),
            ),

            /// FOOTER DE LA CARTA
            Padding(
              padding: const EdgeInsets.fromLTRB(
                7,
                7,
                7,
                8,
              ),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "RECUERDO",
                    style: GoogleFonts.fredoka(
                      color: const Color(0xFF0A1B3D),
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),

                  const Icon(
                    Icons.favorite_rounded,
                    color: Color(0xFF0A1B3D),
                    size: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GalleryPokeBall extends StatelessWidget {
  const _GalleryPokeBall();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
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
            height: 11,
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