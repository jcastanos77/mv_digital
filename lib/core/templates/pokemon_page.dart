import 'package:flutter/material.dart';
import 'package:mv_digital/core/templates/sections/pokemon/pokemon_countdown.dart';
import 'package:mv_digital/core/templates/sections/pokemon/pokemon_event_section.dart';
import 'package:mv_digital/core/templates/sections/pokemon/pokemon_gallery_section.dart';
import 'package:mv_digital/core/templates/sections/pokemon/pokemon_gift_section.dart';
import 'package:mv_digital/core/templates/sections/pokemon/pokemon_hero.dart';
import 'package:mv_digital/core/templates/sections/pokemon/pokemon_snackbar_section.dart';

import '../../landing/cta_section.dart';
import '../../models/invitation_model.dart';

class PokemonPage extends StatefulWidget {
  final InvitationModel data;
  final bool fromPrincipalPage;

  const PokemonPage({
    super.key,
    required this.data,
    required this.fromPrincipalPage,
  });

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return Scaffold(
      backgroundColor: const Color(0xFF0A1B3D),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              PokemonHero(
                title: data.title,
                heroImage: data.heroImage,
                eventDate: data.eventDate,
              ),

              PokemonCountdown(
                eventDate: data.eventDate,
              ),

              PokemonEventSection(
                eventDate: data.eventDate,
                eventTime: data.eventTime,
                location: data.location,
                mapsUrl: data.receptionMaps,
              ),

              PokemonGiftSection(
                data: data,
              ),

              PokemonGallerySection(
                images: data.gallery,
              ),

              PokemonSnackBarSection(
                data: data.snackBar,
              ),

              const SizedBox(height: 40),

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