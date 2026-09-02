import 'package:flutter/material.dart';
import 'package:mv_digital/core/templates/sections/mario_bros/mario_bros_countdown.dart';
import 'package:mv_digital/core/templates/sections/mario_bros/mario_bros_event_section.dart';
import 'package:mv_digital/core/templates/sections/mario_bros/mario_bros_gallery_section.dart';
import 'package:mv_digital/core/templates/sections/mario_bros/mario_bros_gift_section.dart';
import 'package:mv_digital/core/templates/sections/mario_bros/mario_bros_hero.dart';

import '../../landing/cta_section.dart';
import '../../models/invitation_model.dart';

class MarioBrosPage extends StatelessWidget {
  final InvitationModel data;
  final bool fromPrincipalPage;

  const MarioBrosPage({
    super.key,
    required this.data,
    required this.fromPrincipalPage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF87CEEB),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              MarioBrosHero(
                title: data.title,
                heroImage: data.heroImage,
                eventDate: data.eventDate,
              ),

              MarioBrosCountdown(
                eventDate: data.eventDate,
              ),

              MarioBrosEventSection(
                eventDate: data.eventDate,
                eventTime: data.eventTime,
                location: data.location,
                mapsUrl: data.receptionMaps,
              ),

              MarioBrosGiftSection(
                title: data.titleGift ?? '',
                description: data.descriptionGift ?? '',
              ),

              MarioBrosGallerySection(
                images: data.gallery,
              ),

              const SizedBox(height: 40),

              const FooterSection(),
            ],
          ),

          if (fromPrincipalPage)
            Positioned(
              top: 40,
              left: 20,
              child: SafeArea(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.15),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xFFE52521),
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