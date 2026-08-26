import 'package:flutter/material.dart';
import 'package:mv_digital/core/templates/sections/xv/dress_code_section.dart';
import 'package:mv_digital/core/templates/sections/xv/event_details_section.dart';
import 'package:mv_digital/core/templates/sections/xv/rsvp_section.dart';
import 'package:mv_digital/core/templates/sections/xv_sin_imagenes/gift_section.dart';
import 'package:mv_digital/core/templates/sections/xv_sin_imagenes/quince_princess_hero.dart';

import '../../landing/cta_section.dart';
import '../../models/invitation_model.dart';
import '../widgets/countdown_widget.dart';

class QuincePrincessPage extends StatelessWidget {
  final InvitationModel data;
  final bool fromPrincipalPage;

  const QuincePrincessPage({
    super.key,
    required this.data,
    required this.fromPrincipalPage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8ECEE),
      body: Stack(
        children: [
          ListView(
            children: [
              QuincePrincessHero(
                title: data.title,
                eventDate: data.eventDate,
                eventTime: '',
              ),

              const SizedBox(height: 60),

              CountdownWidget(
                eventDate: data.eventDate,
                princessTheme: true,
              ),

              const SizedBox(height: 60),

              EventDetailsSection(
                ceremonyPlace: data.ceremonyPlace,
                ceremonyTime: data.ceremonyTime,
                ceremonyMaps: data.ceremonyMaps,
                receptionPlace: data.receptionPlace,
                receptionTime: data.receptionTime,
                receptionMaps: data.receptionMaps,
                princessTheme: true,
              ),

              const SizedBox(height: 60),

              DressCodeSection(
                dressCode: data.dressCode,
                princessTheme: true,
              ),

              const SizedBox(height: 60),

              const GiftSection(),

              const SizedBox(height: 60),

              RsvpSection(
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
                      color: Colors.black.withOpacity(.25),
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