import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15, // Bajamos un poco el peso de la sombra
                  spreadRadius: -8,
                  color: Colors.black.withAlpha(100), // Usamos withAlpha para mejor performance
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              // saveLayer: false es más rápido pero a veces da errores visuales, déjalo por defecto
              child: Stack(
                children: [
                  /// IMAGEN CON CACHE DE TAMAÑO
                  Image.asset(
                    widget.image,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    // Evita procesar la imagen a máxima calidad en el scroll
                    filterQuality: FilterQuality.none,
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
                    bottom: 30,
                    left: 30,
                    right: 30,
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 26, // Un poco más pequeño para móviles
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: .5,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}