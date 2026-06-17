import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mv_digital/models/invitation_model.dart';
import 'package:mv_digital/themes/invitation_theme.dart';

class BirthdaySnackBar extends StatelessWidget {
  final InvitationModel data;
  final InvitationTheme theme;

  const BirthdaySnackBar({
    super.key,
    required this.data,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final snackBar = data.snackBar;

    if (snackBar == null) {
      return const SizedBox.shrink();
    }

    final items = snackBar.items.isNotEmpty
        ? snackBar.items
        : [
      "🥒 Verduras",
      "🍉 Frutas",
      "🥔 Sabritas",
      "🥜 Cacahuates",
      "🍬 Gomitas",
    ];

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 350,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('barra_mv.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 4,
            sigmaY: 4,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 80,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(.35),
                  Colors.black.withOpacity(.85),
                ],
              ),
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 700,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'logo_mv_digital.png',
                      height: 220,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      snackBar.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: theme.fontFamily,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: theme.secondaryColor,
                        shadows: const [
                          Shadow(
                            color: Colors.black54,
                            blurRadius: 10,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      snackBar.subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.10),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: theme.secondaryColor.withOpacity(.7),
                          width: 2,
                        ),
                      ),
                      child: Text(
                        '${snackBar.startTime} - ${snackBar.endTime}',
                        style: TextStyle(
                          color: theme.secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 12,
                      children: items.map((item) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.12),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white24,
                            ),
                          ),
                          child: Text(
                            item,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Barra de snacks incluida por MV Snacks Bar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}