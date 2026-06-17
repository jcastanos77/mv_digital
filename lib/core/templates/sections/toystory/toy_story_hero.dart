import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../models/invitation_model.dart';
import '../../../../themes/invitation_theme.dart';
import '../../../widgets/scroll_indicator.dart';

class ToyStoryHero extends StatelessWidget {
  final InvitationModel data;
  final InvitationTheme theme;

  const ToyStoryHero({
    super.key,
    required this.data,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 700,
      child: Stack(
        fit: StackFit.expand,
        children: [

          /// Fondo Toy Story
          Image.network(data.heroImage, fit: BoxFit.cover),

          /// Capa oscura ligera
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(.15),
                  Colors.transparent,
                  Colors.black.withOpacity(.45),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const SizedBox(height: 90),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade700,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "¡AL INFINITO Y MÁS ALLÁ!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  Text(
                    data.title,
                    textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 38,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black54,
                            blurRadius: 8,
                            offset: Offset(2, 2),
                          )
                        ],
                      )
                  ),

                  const SizedBox(height: 50),

                  const Text(
                    "CUMPLE",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                  ),

                  Text(
                    "${2}",
                    style: const TextStyle(
                      fontSize: 130,
                      height: .9,
                      fontWeight: FontWeight.w900,
                      color: Color(0xffFACC15),
                      shadows: [
                        Shadow(
                          color: Colors.black38,
                          blurRadius: 10,
                          offset: Offset(3, 3),
                        ),
                      ],
                    ),
                  ),

                  const Text(
                    "AÑOS",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Spacer(),

                  ScrollIndicator(),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}