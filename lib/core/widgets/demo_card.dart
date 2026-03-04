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
  double scale = 1;
  double imageScale = 1;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          scale = 1.04;
          imageScale = 1.08;
        });
      },
      onExit: (_) {
        setState(() {
          scale = 1;
          imageScale = 1;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
          scale: scale,
          child: Container(
            width: 380,
            height: 520,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  blurRadius: 60,
                  spreadRadius: -10,
                  color: Colors.black.withOpacity(.5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Stack(
                children: [

                  /// IMAGEN
                  AnimatedScale(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOut,
                    scale: imageScale,
                    child: Image.asset(
                      widget.image,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),

                  /// OVERLAY
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(.8),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
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
                        fontSize: 28,
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