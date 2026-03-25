import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DemoCard extends StatefulWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const DemoCard({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  State<DemoCard> createState() => _DemoCardState();
}

class _DemoCardState extends State<DemoCard> {
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 300),
          scale: scale,
          child: Container(
            width: 380,
            height: 320,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Stack(
                children: [
                  /// IMAGEN CON CACHE DE TAMAÑO
                  optimicedImage(widget.image,
                      width: double.infinity,
                      height: 240),

                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(.6),
                            Colors.black.withOpacity(.9),
                          ],
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),

                  /// OVERLAY (Gradiente optimizado)
                  const Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black87],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),

                  /// TEXTO
                  Positioned(
                    bottom: 40,
                    left: 30,
                    right: 30,
                    child: Text(
                      widget.title,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget optimicedImage(String path, {double? width, double? height}) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: BoxFit.cover,
      // 1. ESTO ES CLAVE: Muestra un color mientras carga la foto real
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          child: child,
        );
      },
      // 2. Fallback por si la RAM del cel falla al decodificar
      errorBuilder: (context, error, stackTrace) => Container(
        color: Colors.grey[900],
        child: const Icon(Icons.broken_image, color: Colors.white24),
      ),
    );
  }
}