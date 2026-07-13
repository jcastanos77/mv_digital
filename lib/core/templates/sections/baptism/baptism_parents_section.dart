import 'package:flutter/material.dart';

class BaptismParentsSection extends StatelessWidget {
  const BaptismParentsSection({
    super.key,
    required this.father,
    required this.mother,
  });

  final String father;
  final String mother;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const Icon(
            Icons.favorite_outline,
            color: Color(0xFFD4AF37),
            size: 34,
          ),

          const SizedBox(height: 18),

          const Text(
            "CON LA BENDICIÓN DE DIOS",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              letterSpacing: 3,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Mis Papás",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 30),

          Text(
            father,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            mother,
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