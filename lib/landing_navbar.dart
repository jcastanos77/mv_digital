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
        children: const [
          FlutterLogo(),
          SizedBox(width: 12),
          Text("MV Digital"),
        ],
      ),
    );
  }
}