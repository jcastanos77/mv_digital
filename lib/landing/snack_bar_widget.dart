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

    final services = [
      if (snackBar.snackBar)
        ("🍿", "Barra de snacks"),

      if (snackBar.maruchanes)
        ("🍜", "Maruchanes"),

      if (snackBar.elotes)
        ("🌽", "Elotes preparados"),
    ];

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 450,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/barra_mv.png'),
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
              vertical: 60,
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
                      'assets/mv_log.png',
                      height: 220,
                    ),

                    const SizedBox(height: 12),

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
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.10),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: theme.secondaryColor.withOpacity(.6),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time,
                            color: theme.secondaryColor,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${snackBar.startTime} - ${snackBar.endTime}',
                            style: TextStyle(
                              color: theme.secondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      'SERVICIOS DE HOY',
                      style: TextStyle(
                        fontFamily: theme.fontFamily,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: theme.secondaryColor,
                        letterSpacing: 2,
                      ),
                    ),

                    const SizedBox(height: 20),

                    ...services.map((service) {

                      final emoji = service.$1;
                      final title = service.$2;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.10),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.white24,
                          ),
                        ),
                        child: Row(
                          children: [

                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: theme.secondaryColor.withOpacity(.15),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  emoji,
                                  style: const TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 14),

                            Expanded(
                              child: Text(
                                title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),

                    const SizedBox(height: 16),

                    Text(
                      'Preparado especialmente para todos los invitados ✨',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(.85),
                        fontSize: 15,
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