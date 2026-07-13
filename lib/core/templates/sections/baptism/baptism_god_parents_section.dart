import 'package:flutter/material.dart';

class BaptismGodParentsSection extends StatelessWidget {
  const BaptismGodParentsSection({
    super.key,
    required this.godFather,
    required this.godMother,
  });

  final String godFather;
  final String godMother;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const Icon(
            Icons.volunteer_activism_outlined,
            color: Color(0xFFD4AF37),
            size: 34,
          ),

          const SizedBox(height: 18),

          const Text(
            "CON CARIÑO",
            style: TextStyle(
              fontSize: 15,
              letterSpacing: 3,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Mis Padrinos",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 30),

          Text(
            godFather,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            godMother,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}