import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      width: double.infinity,
      color: const Color(0xFF0B0B0D),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 60,
        vertical: isMobile ? 65 : 80,
      ),
      child: Column(
        children: [
          // ─────────────────────────────────────────────
          // LOGO
          // ─────────────────────────────────────────────

          Image.asset(
            "assets/logo_mv_digital.png",
            height: isMobile ? 65 : 85,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 22),

          // ─────────────────────────────────────────────
          // DESCRIPCIÓN
          // ─────────────────────────────────────────────

          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 480,
            ),
            child: const Text(
              "Creamos invitaciones digitales únicas para celebrar "
                  "los momentos que más importan.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF9A9A9F),
                fontSize: 14,
                height: 1.6,
                letterSpacing: .2,
              ),
            ),
          ),

          const SizedBox(height: 42),

          // ─────────────────────────────────────────────
          // DIVISOR
          // ─────────────────────────────────────────────

          Container(
            width: 55,
            height: 2,
            color: const Color(0xFFC49A45),
          ),

          const SizedBox(height: 45),

          // ─────────────────────────────────────────────
          // LINKS
          // ─────────────────────────────────────────────

          isMobile
              ? Column(
            children: [
              _footerColumn(
                "Demos",
                [
                  "Boda",
                  "XV Años",
                  "Cumpleaños",
                  "Bautizo",
                ],
              ),
              const SizedBox(height: 35),
              _footerColumn(
                "Funciones",
                [
                  "Confirmación",
                  "Ubicación",
                  "Cuenta regresiva",
                  "Galería",
                ],
              ),
              const SizedBox(height: 35),
              _footerColumn(
                "Contacto",
                [
                  "WhatsApp",
                  "Instagram",
                ],
              ),
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _footerColumn(
                "Demos",
                [
                  "Boda",
                  "XV Años",
                  "Cumpleaños",
                  "Bautizo",
                ],
              ),
              const SizedBox(width: 110),
              _footerColumn(
                "Funciones",
                [
                  "Confirmación",
                  "Ubicación",
                  "Cuenta regresiva",
                  "Galería",
                ],
              ),
              const SizedBox(width: 110),
              _footerColumn(
                "Contacto",
                [
                  "WhatsApp",
                  "Instagram",
                ],
              ),
            ],
          ),

          const SizedBox(height: 55),

          // ─────────────────────────────────────────────
          // DIVIDER
          // ─────────────────────────────────────────────

          Container(
            width: double.infinity,
            height: 1,
            color: Colors.white.withOpacity(.08),
          ),

          const SizedBox(height: 22),

          // ─────────────────────────────────────────────
          // BOTTOM
          // ─────────────────────────────────────────────

          isMobile
              ? Column(
            children: [
              const Text(
                "© 2026 MV Digital",
                style: TextStyle(
                  color: Color(0xFF68686D),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Invitaciones digitales",
                style: TextStyle(
                  color: Colors.white.withOpacity(.35),
                  fontSize: 12,
                ),
              ),
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "© 2026 MV Digital",
                style: TextStyle(
                  color: Color(0xFF68686D),
                  fontSize: 12,
                ),
              ),
              Text(
                "Invitaciones digitales",
                style: TextStyle(
                  color: Colors.white.withOpacity(.35),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _footerColumn(
      String title,
      List<String> items,
      ) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.8,
            ),
          ),

          const SizedBox(height: 16),

          ...items.map(
                (item) => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Text(
                item,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF8D8D92),
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}