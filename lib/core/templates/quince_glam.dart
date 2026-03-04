import 'package:flutter/material.dart';
import 'package:mv_digital/core/templates/sections/dress_code_section.dart';
import 'package:mv_digital/core/templates/sections/event_details_section.dart';
import 'package:mv_digital/core/templates/sections/footer_section.dart';
import 'package:mv_digital/core/templates/sections/gallery_section.dart';
import 'package:mv_digital/core/templates/sections/rsvp_section.dart';
import 'package:mv_digital/core/templates/xv/quince_hero.dart';

import '../widgets/countdown_widget.dart';

class QuinceGlamPage extends StatefulWidget {
  const QuinceGlamPage({super.key});

  @override
  State<QuinceGlamPage> createState() => _QuinceGlamPageState();
}

class _QuinceGlamPageState extends State<QuinceGlamPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _countdownKey = GlobalKey();

  void _scrollToCountdown() {
    final context = _countdownKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFEA),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                RepaintBoundary(child: QuinceHero(onPressed: _scrollToCountdown)),
                const SizedBox(height: 60),
                CountdownWidget(key: _countdownKey, eventDate: DateTime(2026,12,12)),
                const SizedBox(height: 60),
                const EventDetailsSection(),
                const SizedBox(height: 60),
                const DressCodeSection(),
                const SizedBox(height: 60),
                RepaintBoundary(child: const GallerySection()),
                const SizedBox(height: 60),
                 const RsvpSection(),
                const SizedBox(height: 40),
                const FooterSection()



              ],
            ),
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