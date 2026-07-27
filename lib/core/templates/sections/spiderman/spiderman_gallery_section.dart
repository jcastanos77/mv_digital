import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpidermanGallerySection extends StatelessWidget {
  final List<String> images;

  const SpidermanGallerySection({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const SizedBox.shrink();
    }

    const red = Color(0xFFE62429);
    const blue = Color(0xFF102A4C);
    const background = Color(0xFF071426);

    return Container(
      width: double.infinity,
      color: background,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 50,
      ),
      child: Column(
        children: [
          Text(
            "MIS AVENTURAS",
            textAlign: TextAlign.center,
            style: GoogleFonts.bangers(
              color: Colors.white,
              fontSize: 36,
              letterSpacing: 3,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "Algunos momentos de nuestro pequeño héroe",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.white60,
              fontSize: 13,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 14),

          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: red,
              borderRadius: BorderRadius.circular(20),
            ),
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
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile ? 2 : 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: .82,
                  ),
                  itemBuilder: (context, index) {
                    return _comicImage(
                      images[index],
                      index,
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

  Widget _comicImage(
      String image,
      int index,
      Color red,
      Color blue,
      ) {
    return Transform.rotate(
      angle: index.isEven ? -.015 : .015,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: index % 3 == 0 ? red : blue,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.35),
              blurRadius: 12,
              offset: const Offset(4, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
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
                  color: red,
                  strokeWidth: 2,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}