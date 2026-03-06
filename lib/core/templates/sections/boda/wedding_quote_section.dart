import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeddingQuoteSection extends StatefulWidget {
  final String quote;
  const WeddingQuoteSection({super.key, required this.quote});

  @override
  State<WeddingQuoteSection> createState() => _WeddingQuoteSectionState();
}

class _WeddingQuoteSectionState extends State<WeddingQuoteSection>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    // Retraso ligero para que no compita con hero
    Future.delayed(const Duration(milliseconds: 300), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const background = Color(0xFFF7F5F2);

    return Container(
      color: background,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: Text(
                widget.quote,
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 42,
                  height: 1.4,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF1F1F1F),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}