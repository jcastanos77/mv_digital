import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WeddingGallerySection extends StatelessWidget {
  final List<String> images;

  const WeddingGallerySection({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {

    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 80,
        horizontal: 40,
      ),

      child: Column(
        children: [

          /// TITLE
          Text(
            "Galería",
            style: GoogleFonts.playfairDisplay(
              fontSize: 32,
              color: const Color(0xFF222222),
            ),
          ),

          const SizedBox(height: 60),

          /// GRID
          GridView.builder(

            shrinkWrap: true,

            physics: const NeverScrollableScrollPhysics(),

            itemCount: images.length,

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 3 : 2,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: .8,
            ),

            itemBuilder: (context, index) {

              final image = images[index];

              return ClipRRect(

                borderRadius: BorderRadius.circular(16),

                child: CachedNetworkImage(

                  imageUrl: image,

                  fit: BoxFit.cover,

                  filterQuality: FilterQuality.low,

                  /// reduce uso de RAM
                  memCacheWidth: 900,

                  placeholder: (context, url) {
                    return Container(
                      color: const Color(0xFFF4F4F4),
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  },

                  errorWidget: (context, url, error) {
                    return Container(
                      color: const Color(0xFFF4F4F4),
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}