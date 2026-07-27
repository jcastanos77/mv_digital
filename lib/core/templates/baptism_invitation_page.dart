import 'package:flutter/material.dart';
import 'package:mv_digital/core/templates/sections/baptism/baptism_gift_section.dart';
import 'package:mv_digital/core/templates/sections/baptism/baptism_god_parents_section.dart';
import 'package:mv_digital/core/templates/sections/baptism/baptism_parents_section.dart';
import 'package:mv_digital/core/templates/sections/baptism/baptism_verse_section.dart';
import 'package:mv_digital/core/templates/sections/xv/dress_code_section.dart';
import 'package:mv_digital/core/templates/sections/xv/gallery_section.dart';

import '../../landing/cta_section.dart';
import '../../landing/snack_bar_widget.dart';
import '../../models/invitation_model.dart';
import '../widgets/countdown_widget.dart';
import 'sections/baptism/baptism_hero.dart';
import 'sections/baptism/baptism_event_details_section.dart';

class BaptismGlamPage extends StatefulWidget {
  final InvitationModel data;
  final bool fromPrincipalPage;

  const BaptismGlamPage({
    super.key,
    required this.data,
    required this.fromPrincipalPage,
  });

  @override
  State<BaptismGlamPage> createState() => _BaptismGlamPageState();
}

class _BaptismGlamPageState extends State<BaptismGlamPage> {
  final GlobalKey _countdownKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F1),
      body: Stack(
        children: [
          ListView(
            children: [
              BaptismHero(
                title: data.title,
                heroImage: data.heroImage,
                eventDate: data.eventDate,
              ),

              CountdownWidget(
                key: _countdownKey,
                eventDate: data.eventDate,
              ),
              const SizedBox(height: 40),

              BaptismVerseSection(
                verse: data.bibleVerse ?? "",
              ),

              const SizedBox(height: 40),

              BaptismEventDetailsSection(
                ceremonyPlace: data.ceremonyPlace,
                ceremonyTime: data.ceremonyTime,
                ceremonyMaps: data.ceremonyMaps,
                receptionPlace: data.receptionPlace,
                receptionTime: data.receptionTime,
                receptionMaps: data.receptionMaps,
              ),

              const SizedBox(height: 40),

              BaptismParentsSection(
                father: data.father ?? '',
                mother: data.mother ?? '',
              ),

              const SizedBox(height: 40),

              BaptismGodParentsSection(
               godParents: data.godParents ?? [],
              ),
              const SizedBox(height: 40),

              BaptismGiftSection(
                descriptionGift: data.descriptionGift ?? '',
                titleGift: data.titleGift ?? '',
              ),

              const SizedBox(height: 40),

              DressCodeSection(dressCode: data.dressCode),

              const SizedBox(height: 20),

              GallerySection(
                images: data.gallery,
              ),

              const SizedBox(height: 30),

              const FooterSection(),
            ],
          ),

          if (widget.fromPrincipalPage)
            Positioned(
              top: 40,
              left: 20,
              child: SafeArea(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}