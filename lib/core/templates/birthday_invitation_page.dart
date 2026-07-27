import 'package:flutter/material.dart';
import 'package:mv_digital/core/templates/sections/birthday/birthday_countdown.dart';
import 'package:mv_digital/core/templates/sections/birthday/birthday_dress_code.dart';
import 'package:mv_digital/core/templates/sections/birthday/birthday_event_info.dart';
import 'package:mv_digital/core/templates/sections/birthday/birthday_gallery.dart';
import 'package:mv_digital/core/templates/sections/birthday/birthday_gift.dart';
import 'package:mv_digital/core/templates/sections/birthday/cowbow/birthday_hero.dart';

import '../../landing/cta_section.dart';
import '../../landing/snack_bar_widget.dart';
import '../../models/invitation_model.dart';
import '../../themes/invitation_theme.dart';
import '../../themes/theme_resolver.dart';

class BirthdayInvitationPage extends StatelessWidget {

  final InvitationModel data;
  final InvitationTheme theme;
  final bool fromPrincipalPage;

  const BirthdayInvitationPage({
    super.key,
    required this.data,
    required this.theme,
    required this.fromPrincipalPage
  });

  @override
  Widget build(BuildContext context) {

    final themeName = data.theme;

    final InvitationTheme theme =
    resolveBirthdayTheme(themeName);

    return Scaffold(
      body:Stack(
        children: [
          ListView(
          children: [
            BirthdayHero(
              data: data,
              theme: theme,
            ),

            BirthdayCountdown(
              data: data,
              theme: theme,
            ),

            BirthdayEventInfo(
              data: data,
              theme: theme,
            ),

            BirthdayGift(
              data: data,
              theme: theme,
            ),

            BirthdayDressCode(
              data: data,
              theme: theme,
            ),

            BirthdayGallery(
              data: data,
              theme: theme,
            ),

            BirthdaySnackBar(
              data: data,
              theme: theme,
            ),

            const FooterSection(),
          ],
        ),
          fromPrincipalPage ? Positioned(
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
          ) : Container(),
        ]
      ),
    );
  }
}