import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_digital/core/templates/sections/boda/wedding_event_section.dart';
import 'package:mv_digital/core/templates/sections/boda/wedding_gallery_section.dart';
import 'package:mv_digital/core/templates/sections/boda/wedding_hero_countdown.dart';
import 'package:mv_digital/core/templates/sections/boda/wedding_hero_section.dart';
import 'package:mv_digital/core/templates/sections/boda/wedding_quote_section.dart';
import 'package:mv_digital/core/templates/sections/boda/wedding_rsvp_section.dart';
import 'package:mv_digital/core/templates/sections/footer_section.dart';
import '../widgets/countdown_widget.dart';
import '../widgets/fade_in_up.dart';

class WeddingGlamTemplate extends StatefulWidget {
  const WeddingGlamTemplate({super.key});

  @override
  State<WeddingGlamTemplate> createState() => _WeddingGlamTemplateState();
}

class _WeddingGlamTemplateState extends State<WeddingGlamTemplate> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [

            /// HERO
            WeddingHeroSection(),

            FadeInUp(
              child: WeddingCountdownSection(),
            ),

            /// DETALLES DEL EVENTO
            FadeInUp(
              child: const WeddingEventSection(),
            ),

            FadeInUp(
              child: WeddingQuoteSection(),
            ),

            /// GALERÍA
            FadeInUp(
              child: const WeddingGallerySection(),
            ),

            /// RSVP
            FadeInUp(
              child: const WeddingRsvpSection(),
            ),

            /// FOOTER
            const FooterSection(),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}