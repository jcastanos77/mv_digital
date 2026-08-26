import 'package:flutter/material.dart';

import '../../../../models/invitation_model.dart';
import '../../../../themes/invitation_theme.dart';

class BirthdayGift extends StatelessWidget {
  final InvitationModel data;
  final InvitationTheme theme;

  const BirthdayGift({
    super.key,
    required this.data,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final title = data.giftTitle ?? "Un obsequio con cariño";
    final showGift = data.showGift ?? false;

    final description = data.giftDescription ??
        "Tu presencia es el regalo más importante para nosotros. "
            "Si deseas tener un detalle con nuestra familia, te compartimos algunas sugerencias que recibiremos con mucho cariño y gratitud.";

    return showGift ? Container(
      width: double.infinity,
      color: const Color(0xFFF7F3EE),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 40,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 45,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                Icons.card_giftcard_rounded,
                color: theme.primaryColor,
                size: 42,
              ),

              const SizedBox(height: 20),

              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 34,
                  fontWeight: FontWeight.w500,
                  fontFamily: "CormorantGaramond",
                ),
              ),

              const SizedBox(height: 18),

              Container(
                width: 70,
                height: 2,
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(.5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 28),

              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.8,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 35),

              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 20,
                children: [
                  _giftItem(
                    icon: Icons.toys_rounded,
                    title: "Juguetes",
                    subtitle: "Adecuados para su edad.",
                  ),
                  _giftItem(
                    icon: Icons.checkroom_rounded,
                    title: "Ropa",
                    subtitle: "Talla 6 años o superior.",
                  ),
                  _giftItem(
                    icon: Icons.payments_rounded,
                    title: "Efectivo",
                    subtitle: "Será recibido con mucho cariño.",
                  ),
                ],
              ),

              const SizedBox(height: 35),

              Text(
                "¡Gracias por acompañarnos en este día tan especial!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              Icon(
                Icons.favorite,
                size: 18,
                color: theme.primaryColor,
              ),
            ],
          ),
        ),
      ),
    ) : Container();
  }

  Widget _giftItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return SizedBox(
      width: 220,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: theme.primaryColor.withOpacity(.12),
            child: Icon(
              icon,
              color: theme.primaryColor,
              size: 30,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: TextStyle(
              color: theme.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}