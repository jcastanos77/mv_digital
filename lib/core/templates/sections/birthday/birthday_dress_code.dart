import 'package:flutter/material.dart';
import 'package:mv_digital/models/invitation_model.dart';
import 'package:mv_digital/themes/invitation_theme.dart';

class BirthdayDressCode extends StatelessWidget {

  final InvitationModel data;
  final InvitationTheme theme;

  const BirthdayDressCode({
    super.key,
    required this.data,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {

    if (data.dressCode.isEmpty) {
      return const SizedBox();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 90,
        horizontal: 20,
      ),
      color: theme.primaryColor,

      child: Column(
        children: [

          Text(
            "Código de vestimenta",
            style: TextStyle(
              fontFamily: theme.fontFamily,
              fontSize: 36,
              color: theme.secondaryColor,
            ),
          ),

          const SizedBox(height: 30),

          Icon(
            Icons.checkroom,
            size: 50,
            color: theme.secondaryColor,
          ),

          const SizedBox(height: 30),

          Text(
            data.dressCode,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: theme.fontFamily,
              fontSize: 20,
              color: theme.secondaryColor,
              height: 1.5,
            ),
          ),

        ],
      ),
    );
  }
}