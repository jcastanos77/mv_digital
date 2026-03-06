import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeddingGallerySection extends StatelessWidget {
  const WeddingGallerySection({super.key});

  @override
  Widget build(BuildContext context) {

    final images = [
      "https://images.unsplash.com/photo-1606800052052-a08af7148866?q=80&w=1200&auto=format&fit=crop",
      "https://images.unsplash.com/photo-1523438885200-e635ba2c371e?q=80&w=1200&auto=format&fit=crop",
      "https://images.unsplash.com/photo-1529636798458-92182e662485?q=80&w=1200&auto=format&fit=crop",
      "https://images.unsplash.com/photo-1515934751635-c81c6bc9a2d8?q=80&w=1200&auto=format&fit=crop",
      "https://images.unsplash.com/photo-1550784718-990c6de52adf?q=80&w=1200&auto=format&fit=crop",
      "https://plus.unsplash.com/premium_photo-1711132425055-1c289c69b950?q=80&w=1200&auto=format&fit=crop",
    ];

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