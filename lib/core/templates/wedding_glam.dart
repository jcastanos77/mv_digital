import 'package:flutter/material.dart';
import 'package:mv_digital/core/templates/sections/boda/wedding_event_section.dart';
import 'package:mv_digital/core/templates/sections/boda/wedding_gallery_section.dart';
import 'package:mv_digital/core/templates/sections/boda/wedding_hero_countdown.dart';
import 'package:mv_digital/core/templates/sections/boda/wedding_hero_section.dart';
import 'package:mv_digital/core/templates/sections/boda/wedding_quote_section.dart';
import 'package:mv_digital/core/templates/sections/footer_section.dart';
import 'package:mv_digital/core/templates/sections/rsvp_section.dart';

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
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            children: const [

                /// HERO
                WeddingHeroSection(),

                const WeddingCountdownSection(),

                /// DETALLES DEL EVENTO
                const WeddingEventSection(),

                const WeddingQuoteSection(),

                /// GALERÍA
                RepaintBoundary(child:const WeddingGallerySection()),


                /// RSVP
                const RsvpSection(),

                /// FOOTER
                const FooterSection(),

                const SizedBox(height: 60),
              ],
          ),
          Positioned(
            top: 40,
            left: 20,
            child: SafeArea(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}