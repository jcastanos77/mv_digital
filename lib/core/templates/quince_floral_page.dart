import 'package:flutter/material.dart';
import 'package:mv_digital/core/templates/sections/xv_floral/quince_floral_countdown.dart';
import 'package:mv_digital/core/templates/sections/xv_floral/quince_floral_dress_code.dart';
import 'package:mv_digital/core/templates/sections/xv_floral/quince_floral_event_details.dart';
import 'package:mv_digital/core/templates/sections/xv_floral/quince_floral_gift_section.dart';
import 'package:mv_digital/core/templates/sections/xv_floral/quince_floral_hero.dart';
import 'package:mv_digital/core/templates/sections/xv_floral/rsvps_floral_section.dart';

import '../../landing/cta_section.dart';
import '../../models/invitation_model.dart';

class QuinceFloralPage extends StatelessWidget {
  final InvitationModel data;
  final bool fromPrincipalPage;

  const QuinceFloralPage({
    super.key,
    required this.data,
    required this.fromPrincipalPage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            children: [
              QuinceFloralHero(
                title: data.title,
                eventDate: data.eventDate,
                eventTime: data.eventTime,
              ),

              const SizedBox(height: 60),

              QuinceFloralCountdown(
                eventDate: data.eventDate,
              ),

              const SizedBox(height: 60),

              QuinceFloralEventDetails(
                ceremonyPlace: data.ceremonyPlace,
                ceremonyTime: data.ceremonyTime,
                ceremonyMaps: data.ceremonyMaps,
                receptionPlace: data.receptionPlace,
                receptionTime: data.receptionTime,
                receptionMaps: data.receptionMaps,
              ),

              const SizedBox(height: 60),

              QuinceFloralDressCode(
                dressCode: data.dressCode,

              ),

              const SizedBox(height: 60),

              QuinceFloralGiftSection(
                title: data.titleGift ?? 'Regalo en efectivo',
                description: data.descriptionGift ?? '',
              ),

              const SizedBox(height: 60),

              RsvpsFloralSectionSection(
                invitationId: data.id,
                princessTheme: true,
              ),

              const SizedBox(height: 60),

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
                          color: Colors.black.withOpacity(.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xFFC6A15B),
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