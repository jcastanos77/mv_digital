import 'package:flutter/material.dart';

class FullscreenGallery extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const FullscreenGallery({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<FullscreenGallery> createState() => _FullscreenGalleryState();
}

class _FullscreenGalleryState extends State<FullscreenGallery> {

  late final PageController _controller;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [

          /// GALERIA
          PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,

            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },

            itemBuilder: (context, index) {

              return InteractiveViewer(
                minScale: 1,
                maxScale: 4,

                child: Center(
                  child: Image.network(
                    widget.images[index],

                    fit: BoxFit.contain,

                    /// LIMITA RESOLUCION PARA WEB
                    cacheWidth: 1600,
                    filterQuality: FilterQuality.low,

                    loadingBuilder: (context, child, progress) {

                      if (progress == null) return child;

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              );
            },
          ),

          /// CONTADOR
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "${currentIndex + 1} / ${widget.images.length}",
                style: const TextStyle(
                  color: Colors.white70,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),

          /// BOTON CERRAR
          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),

        ],
      ),
    );
  }
}