import 'package:flutter/material.dart';
import 'package:mv_digital/core/templates/sections/spiderman/spiderman_countdown.dart';
import 'package:mv_digital/core/templates/sections/spiderman/spiderman_event_section.dart';
import 'package:mv_digital/core/templates/sections/spiderman/spiderman_gallery_section.dart';
import 'package:mv_digital/core/templates/sections/spiderman/spiderman_hero.dart';
import 'package:mv_digital/core/templates/sections/spiderman/spiderman_snack_bar_section.dart';

import '../../landing/cta_section.dart';
import '../../models/invitation_model.dart';

class SpidermanPage extends StatefulWidget {
  final InvitationModel data;
  final bool fromPrincipalPage;

  const SpidermanPage({
    super.key,
    required this.data,
    required this.fromPrincipalPage,
  });

  @override
  State<SpidermanPage> createState() => _SpidermanPageState();
}

class _SpidermanPageState extends State<SpidermanPage> {

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return Scaffold(
      backgroundColor: const Color(0xFF071426),
      body: Stack(
        children: [

          /// CONTENIDO
          ListView(
            padding: EdgeInsets.zero,
            children: [

              /// HERO
               SpidermanHero(
                 title: data.title,
                 heroImage: data.heroImage,
                 eventDate: data.eventDate,
               ),

              /// COUNTDOWN
              SpidermanCountdown(
                eventDate: data.eventDate,
              ),

              /// INFORMACIÓN DEL EVENTO
              SpidermanEventSection(
                eventDate: data.eventDate,
                eventTime: data.eventTime,
                location: data.location,
                mapsUrl: data.receptionMaps,
              ),

              /// GALERÍA
               SpidermanGallerySection(
                 images: data.gallery,
               ),

              /// SNACK BAR
               SpidermanSnackBarSection(
                 data: data.snackBar,
               ),

              const SizedBox(height: 40),

              const FooterSection(),
            ],
          ),

          /// BOTÓN REGRESAR
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
                      color: Colors.black.withOpacity(.45),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(.20),
                      ),
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