import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_digital/core/widgets/scroll_indicator.dart';

class WeddingHeroSection extends StatefulWidget {
  final String title;
  final DateTime eventDate;
  final String backgroundImage;

  const WeddingHeroSection({
    super.key,
    required this.title,
    required this.eventDate,
    required this.backgroundImage,
  });


  @override
  State<WeddingHeroSection> createState() => _WeddingHeroSectionState();
}

class _WeddingHeroSectionState extends State<WeddingHeroSection>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        fit: StackFit.expand,
        children: [

          /// Background Image
          CachedNetworkImage(
            imageUrl: widget.backgroundImage,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.low,
          ),

          /// Dark overlay
          Container(
            color: Colors.black.withOpacity(0.45),
          ),

          /// Animated content
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 56,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      _formatDate(widget.eventDate),
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        letterSpacing: 4,
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 80),

                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 2000),
                      curve: Curves.easeInOut,
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(0, 10 * (1 - value)),
                          child: Opacity(
                            opacity: value,
                            child: child,
                          ),
                        );
                      },
                      child: ScrollIndicator(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  String _formatDate(DateTime date) {

    const months = [
      '',
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre'
    ];

    return "${date.day} · ${months[date.month]} · ${date.year}";
  }
}