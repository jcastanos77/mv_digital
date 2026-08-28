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
        cacheExtent: 0,
        slivers: [
          const LandingNavbar(),

          const SliverToBoxAdapter(
            child: HeroSection(),
          ),

          SliverToBoxAdapter(
            child: RepaintBoundary(
              child: DemoSection(),
            ),
          ),

          const SliverToBoxAdapter(
            child: FeatureSection(),
          ),

          const SliverToBoxAdapter(
            child: HowItWorksSection(),
          ),

          const SliverToBoxAdapter(
            child: FooterSection(),
          ),
        ],
      ),
    );
  }
}