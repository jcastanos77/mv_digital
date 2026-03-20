import 'package:flutter/material.dart';
import 'package:mv_digital/models/invitation_model.dart';
import 'package:mv_digital/themes/invitation_theme.dart';

import '../../../../widgets/scroll_indicator.dart';

class BirthdayHero extends StatelessWidget {

  final InvitationModel data;
  final InvitationTheme theme;

  const BirthdayHero({
    super.key,
    required this.data,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 650,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(data.heroImage),
          fit: BoxFit.cover,
        ),
      ),

      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                "Estás invitado a celebrar",
                style: TextStyle(
                  fontFamily: theme.fontFamily,
                  fontSize: 22,
                  color: theme.secondaryColor,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                data.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: theme.fontFamily,
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: theme.secondaryColor,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                data.quote,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: theme.fontFamily,
                  fontSize: 18,
                  color: theme.secondaryColor,
                ),
              ),

              const SizedBox(height: 40),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.secondaryColor,
                    width: 2,
                  ),
                ),
                child: Text(
                  data.eventTime,
                  style: TextStyle(
                    fontFamily: theme.fontFamily,
                    fontSize: 18,
                    color: theme.secondaryColor,
                  ),
                ),
              ),

              ScrollIndicator()

            ],
          ),
        ),
      ),
    );
  }
}