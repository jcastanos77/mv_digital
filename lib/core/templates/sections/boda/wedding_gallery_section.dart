import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeddingGallerySection extends StatelessWidget {
  final List<String> images;

  const WeddingGallerySection({super.key, required this.images});

  @override
  Widget build(BuildContext context) {

    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
      child: Column(
        children: [

          Text(
            "Galería",
            style: GoogleFonts.playfairDisplay(
              fontSize: 32,
              color: const Color(0xFF222222),
            ),
          ),

          const SizedBox(height: 80),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: images.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 3 : 2,
              crossAxisSpacing: 40,
              mainAxisSpacing: 40,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {

              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  images[index],
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.low,
                  cacheWidth: 900,
                ),
              );

            },
          ),
        ],
      ),
    );
  }
}