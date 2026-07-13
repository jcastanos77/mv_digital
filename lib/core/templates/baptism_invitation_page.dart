import 'package:flutter/material.dart';
import 'package:mv_digital/core/templates/sections/baptism/baptism_god_parents_section.dart';
import 'package:mv_digital/core/templates/sections/baptism/baptism_parents_section.dart';
import 'package:mv_digital/core/templates/sections/xv/gallery_section.dart';

import '../../landing/cta_section.dart';
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

              const SizedBox(height: 60),

              CountdownWidget(
                key: _countdownKey,
                eventDate: data.eventDate,
              ),

              const SizedBox(height: 60),

              BaptismEventDetailsSection(
                ceremonyPlace: data.ceremonyPlace,
                ceremonyTime: data.ceremonyTime,
                ceremonyMaps: data.ceremonyMaps,
                receptionPlace: data.receptionPlace,
                receptionTime: data.receptionTime,
                receptionMaps: data.receptionMaps,
              ),

              const SizedBox(height: 60),

              BaptismParentsSection(
                father: data.father ?? '',
                mother: data.mother ?? '',
              ),

              const SizedBox(height: 60),

              BaptismGodParentsSection(
                godFather: data.godFather ?? '',
                godMother: data.godMother ?? '',
              ),

              const SizedBox(height: 60),

              GallerySection(
                images: data.gallery,
              ),

              const SizedBox(height: 60),

              /*BirthdaySnackBar(
                data: data,
                theme: theme,
              ),*/

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