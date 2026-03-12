import 'package:flutter/material.dart';
import 'package:mv_digital/landing/feature_section.dart';

import '../core/templates/sections/xv/footer_section.dart';
import '../landing_navbar.dart';
import 'demo_section.dart';
import 'hero_section.dart';
import 'how_it_works_section.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const LandingNavbar(),
          /// HERO
          const SliverToBoxAdapter(
            child: HeroSection(),
          ),

          /// DEMO
          SliverToBoxAdapter(
            child: DemoSection(),
          ),

          /// FEATURES
          const SliverToBoxAdapter(
            child: FeatureSection(),
          ),

          /// HOW IT WORKS
          const SliverToBoxAdapter(
            child: HowItWorksSection(),
          ),

          /// FOOTER
          const SliverToBoxAdapter(
            child: FooterSection(),
          ),
        ],
      ),
    );
  }
}