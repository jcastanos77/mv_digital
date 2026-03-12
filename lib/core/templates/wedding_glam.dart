import 'package:flutter/material.dart';
import 'package:mv_digital/core/templates/sections/boda/wedding_event_section.dart';
import 'package:mv_digital/core/templates/sections/boda/wedding_gallery_section.dart';
import 'package:mv_digital/core/templates/sections/boda/wedding_hero_countdown.dart';
import 'package:mv_digital/core/templates/sections/boda/wedding_hero_section.dart';
import 'package:mv_digital/core/templates/sections/boda/wedding_quote_section.dart';
import 'package:mv_digital/core/templates/sections/xv/rsvp_section.dart';

import '../../landing/cta_section.dart';
import '../../models/event_info.dart';
import '../../models/invitation_model.dart';


class WeddingGlamTemplate extends StatefulWidget {

  final InvitationModel data;

  const WeddingGlamTemplate({
    super.key,
    required this.data,
  });

  @override
  State<WeddingGlamTemplate> createState() => _WeddingGlamTemplateState();
}

class _WeddingGlamTemplateState extends State<WeddingGlamTemplate> {

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    final data = widget.data;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          ListView(
            controller: _scrollController,
            children: [

              /// HERO
              WeddingHeroSection(
                title: data.title,
                eventDate: data.eventDate,
                backgroundImage: data.heroImage,
              ),

              /// COUNTDOWN
              WeddingCountdownSection(
                eventDate: data.eventDate,
              ),

              /// EVENT DETAILS
              WeddingEventSection(
                ceremony: EventInfo(
                  imageUrl: data.ceremonyImage,
                  title: "CEREMONIA",
                  place: data.ceremonyPlace,
                  time: data.ceremonyTime,
                  mapsUrl: data.ceremonyMaps,
                ),
                reception: EventInfo(
                  imageUrl: data.receptionImage,
                  title: "RECEPCIÓN",
                  place: data.receptionPlace,
                  time: data.receptionTime,
                  mapsUrl: data.receptionMaps,
                ),
              ),

              /// QUOTE
              WeddingQuoteSection(
                quote: data.quote,
              ),

              /// GALERIA
              WeddingGallerySection(
                images: data.gallery,
              ),

              /// RSVP
              RsvpSection(
                invitationId: data.id,
              ),

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