import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'fullscreen_gallery.dart';


class GallerySection extends StatelessWidget {

  final List<String> images;

  const GallerySection({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {

    if (images.isEmpty) {
      return const SizedBox();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 30),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Column(
        children: [

          /// TITULO
          Container(
            width: 40,
            height: 2,
            color: const Color(0xFFC6A23E),
          ),

          const SizedBox(height: 20),

          Text(
            "Galería",
            style: GoogleFonts.playfairDisplay(
              fontSize: 30,
              color: const Color(0xFF3A2726),
            ),
          ),

          const SizedBox(height: 40),

          /// GRID
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: images.length,

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: .8,
            ),

            itemBuilder: (context, index) {

              final image = images[index];

              return GestureDetector(
                onTap: () {

                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 350),
                      pageBuilder: (_, animation, __) {

                        return FadeTransition(
                          opacity: animation,
                          child: FullscreenGallery(
                            images: images,
                            initialIndex: index,
                          ),
                        );

                      },
                    ),
                  );

                },

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),

                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.low,
                    cacheWidth: 900,
                  ),

                ),
              );

            },
          ),
        ],
      ),
    );
  }
}