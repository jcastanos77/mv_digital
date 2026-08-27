import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../models/invitation_model.dart';

class PokemonGiftSection extends StatelessWidget {
  final InvitationModel data;

  const PokemonGiftSection({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final showGift = data.showGift ?? false;

    if (!showGift) {
      return const SizedBox.shrink();
    }

    final title = data.giftTitle ?? "UN REGALO ESPECIAL";

    final description = data.giftDescription ??
        "Tu presencia es lo más importante para nosotros. "
            "Pero si deseas traer un regalo para el festejado, "
            "cualquier detalle será recibido con mucho cariño.";

    return Container(
      width: double.infinity,
      color: const Color(0xFF0A1B3D),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 45,
      ),
      child: Column(
        children: [
          /// POKÉBOLA
          const Icon(
            Icons.catching_pokemon_rounded,
            color: Color(0xFFFFCB05),
            size: 42,
          ),

          const SizedBox(height: 14),

          /// TÍTULO
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.fredoka(
              color: const Color(0xFFFFCB05),
              fontSize: 32,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),

          const SizedBox(height: 10),

          Container(
            width: 65,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE53935),
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          const SizedBox(height: 32),

          /// TARJETA PRINCIPAL
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 32,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1B356E),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: const Color(0xFFFFCB05),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.30),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                /// DESCRIPCIÓN
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.fredoka(
                    color: Colors.white.withOpacity(.85),
                    fontSize: 16,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 35),

                /// OPCIONES
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 20,
                  children: [
                    _giftItem(
                      icon: Icons.toys_rounded,
                      title: "JUGUETES",
                      subtitle: "Para seguir la aventura",
                      color: const Color(0xFFE53935),
                    ),
                    _giftItem(
                      icon: Icons.checkroom_rounded,
                      title: "ROPA",
                      subtitle: "Para nuevos entrenadores",
                      color: const Color(0xFFFFCB05),
                    ),
                    _giftItem(
                      icon: Icons.payments_rounded,
                      title: "EFECTIVO",
                      subtitle: "Con mucho cariño",
                      color: const Color(0xFF55C1FF),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                /// MENSAJE FINAL
                Text(
                  "¡GRACIAS POR SER PARTE DE ESTA AVENTURA!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.fredoka(
                    color: const Color(0xFFFFCB05),
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),

                const SizedBox(height: 12),

                const Icon(
                  Icons.favorite_rounded,
                  color: Color(0xFFE53935),
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _giftItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return SizedBox(
      width: 130,
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(.25),
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF0A1B3D),
              size: 28,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.fredoka(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.fredoka(
              color: Colors.white60,
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}