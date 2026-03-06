import 'package:flutter/material.dart';
import 'package:mv_digital/landing/feature_section.dart';

import '../core/templates/sections/footer_section.dart';
import 'demo_section.dart';
import 'hero_section.dart';
import 'how_it_works_section.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: const [

          /// HERO
          SliverToBoxAdapter(
            child: HeroSection(),
          ),

          /// DEMO
          SliverToBoxAdapter(
            child: DemoSection(),
          ),

          /// FEATURES
          SliverToBoxAdapter(
            child: FeatureSection(),
          ),

          /// HOW IT WORKS
          SliverToBoxAdapter(
            child: HowItWorksSection(),
          ),

          /// FOOTER
          SliverToBoxAdapter(
            child: FooterSection(),
          ),
        ],
      ),
    );
  }
}