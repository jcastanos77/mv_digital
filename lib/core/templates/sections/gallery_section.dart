import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'fullscreen_gallery.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {

    final images = [
      "https://images.unsplash.com/photo-1763959949881-22f1f13cf082?q=80&w=1200&auto=format&fit=crop",
      "https://images.unsplash.com/photo-1763959951409-430bfebd5515?q=80&w=1200&auto=format&fit=crop",
      "https://images.unsplash.com/photo-1763959944953-d8f723c34bff?q=80&w=1200&auto=format&fit=crop",
      "https://images.unsplash.com/photo-1656918839048-cd1c3df3c0e9?q=80&w=1200&auto=format&fit=crop",
      "https://images.unsplash.com/photo-1763959946113-096f6a57422b?q=80&w=1200&auto=format&fit=crop",
      "https://images.unsplash.com/photo-1763959955470-c7bb7a825d0b?q=80&w=1200&auto=format&fit=crop",
      "https://images.unsplash.com/photo-1763625645366-b12410f63f6a?q=80&w=1200&auto=format&fit=crop",
      "https://images.unsplash.com/photo-1763959947199-d6a84743ba81?q=80&w=1200&auto=format&fit=crop",
    ];

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

                    /// LIMITA RESOLUCION
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