import 'package:flutter/material.dart';
import 'package:mv_digital/core/templates/sections/xv/dress_code_section.dart';
import 'package:mv_digital/core/templates/sections/xv/event_details_section.dart';
import 'package:mv_digital/core/templates/sections/xv/gallery_section.dart';
import 'package:mv_digital/core/templates/sections/xv/quince_hero.dart';
import 'package:mv_digital/core/templates/sections/xv/rsvp_section.dart';

import '../../landing/cta_section.dart';
import '../../models/invitation_model.dart';
import '../widgets/countdown_widget.dart';

class QuinceGlamPage extends StatefulWidget {

  final InvitationModel data;

  const QuinceGlamPage({
    super.key,
    required this.data,
  });

  @override
  State<QuinceGlamPage> createState() => _QuinceGlamPageState();
}
class _QuinceGlamPageState extends State<QuinceGlamPage> {
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
    final data = widget.data;

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFEA),
      body: Stack(
        children: [
          ListView(
            children: [
              QuinceHero(
                onPressed: _scrollToCountdown,
                title: data.title,
                heroImage: data.heroImage,
                eventDate: data.eventDate,
                eventTime: '',),
              const SizedBox(height: 60),
              CountdownWidget(key: _countdownKey, eventDate: data.eventDate),
              const SizedBox(height: 60),
              EventDetailsSection(
                ceremonyPlace: data.ceremonyPlace,
                ceremonyTime: data.ceremonyTime,
                ceremonyMaps: data.ceremonyMaps,
                receptionPlace: data.receptionPlace,
                receptionTime: data.receptionTime,
                receptionMaps: data.receptionMaps,
              ),
              const SizedBox(height: 60),
               DressCodeSection(dressCode: data.dressCode,),
              const SizedBox(height: 60),
              GallerySection(
                images: data.gallery,
              ),
              const SizedBox(height: 60),
              RsvpSection(
                invitationId: data.id,
              ),
              const SizedBox(height: 40),
              const FooterSection(),
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