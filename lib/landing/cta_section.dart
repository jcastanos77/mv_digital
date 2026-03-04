import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {

    bool isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isMobile ? 20 : 40,
      ),
      color: Colors.black,
      child: Column(
        children: [

          /// LOGO + DESCRIPCION
          Column(
            children: [

              Image.asset(
                "assets/logo_mv_digital.png",
                height: isMobile ? 70 : 100,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 20),

              const Text(
                "Invitaciones digitales elegantes para bodas y XV años.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),

            ],
          ),

          const SizedBox(height: 60),

          /// LINKS
          isMobile
              ? Column(
            children: [

              _footerColumn("Demos", ["Boda", "XV Años"]),

              const SizedBox(height: 30),

              _footerColumn(
                "Funciones",
                ["Confirmación", "Ubicación", "Cuenta regresiva"],
              ),

              const SizedBox(height: 30),

              _footerColumn(
                "Contacto",
                ["WhatsApp", "Instagram"],
              ),

            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              _footerColumn("Demos", ["Boda", "XV Años"]),

              const SizedBox(width: 80),

              _footerColumn(
                "Funciones",
                ["Confirmación", "Ubicación", "Cuenta regresiva"],
              ),

              const SizedBox(width: 80),

              _footerColumn(
                "Contacto",
                ["WhatsApp", "Instagram"],
              ),

            ],
          ),

          const SizedBox(height: 60),

          const Divider(color: Colors.white24),

          const SizedBox(height: 20),

          const Text(
            "© 2026 MV Digital. Todos los derechos reservados.",
            style: TextStyle(
              color: Colors.white38,
              fontSize: 14,
            ),
          )

        ],
      ),
    );
  }

  Widget _footerColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 10),

        ...items.map(
              (item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              item,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
          ),
        )

      ],
    );
  }
}