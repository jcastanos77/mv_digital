import 'package:flutter/material.dart';

class LandingNavbar extends StatelessWidget {
  const LandingNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.black.withOpacity(.8),
      elevation: 0,
      title: Row(
        children: [
          Image.asset('assets/logo_mv_digital.png', width: 40, height: 40,),
          const SizedBox(width: 12),
          const Text("MV Digital"),
        ],
      ),
    );
  }
}