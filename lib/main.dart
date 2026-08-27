import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'firebase_options.dart';

/// LANDING / INVITACIONES
import 'invitation_loader_page.dart';
import 'landing/landing_mv_page.dart';
import 'rsvpsPage.dart';

/// ADMIN
import 'admin/admin_dashboard.dart';
import 'admin/create_invitation_page.dart';
import 'admin/select_invitation_type_page.dart';
import 'admin/create_invitation_birthday.dart';
import 'admin/baptism_builder_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Fechas en español
  await initializeDateFormatting('es');

  /// URLs sin #
  usePathUrlStrategy();

  runApp(const MyApp());
}

final GoRouter router = GoRouter(
  routes: [
    /// =========================
    /// LANDING PRINCIPAL
    /// =========================
    GoRoute(
      path: '/',
      builder: (context, state) => const LandingPage(),
    ),

    /// =========================
    /// INVITACIONES
    /// =========================
    GoRoute(
      path: '/invitation/:slug',
      builder: (context, state) {
        final slug = state.pathParameters['slug']!;

        return InvitationLoaderPage(
          slug: slug,
        );
      },
    ),

    /// =========================
    /// RSVP
    /// =========================
    GoRoute(
      path: '/invitation/:slug/rsvps',
      builder: (context, state) {
        final slug = state.pathParameters['slug']!;

        return RsvpsPage(
          slug: slug,
        );
      },
    ),

    /// =========================
    /// DEMOS
    /// =========================
    GoRoute(
      path: '/demo/boda',
      builder: (context, state) =>
      const InvitationLoaderPage(
        slug: 'demo-boda',
      ),
    ),

    GoRoute(
      path: '/demo/xv',
      builder: (context, state) =>
      const InvitationLoaderPage(
        slug: 'demo-xv',
      ),
    ),

    GoRoute(
      path: '/demo/birthday',
      builder: (context, state) =>
      const InvitationLoaderPage(
        slug: 'demo-birthday',
      ),
    ),

    GoRoute(
      path: '/demo/bautizo',
      builder: (context, state) =>
      const InvitationLoaderPage(
        slug: 'demo-bautizo',
      ),
    ),

    /// =========================
    /// ADMIN
    /// =========================
    GoRoute(
      path: '/admin',
      builder: (context, state) =>
      const AdminDashboard(),
    ),

    GoRoute(
      path: '/admin/create',
      builder: (context, state) =>
      const CreateInvitationPage(),
    ),

    GoRoute(
      path: '/admin/select-type',
      builder: (context, state) =>
      const SelectInvitationTypePage(),
    ),

    GoRoute(
      path: '/admin/create-birthday',
      builder: (context, state) =>
      const BirthdayBuilderPage(),
    ),

    GoRoute(
      path: '/admin/create-baptism',
      builder: (context, state) =>
      const BaptismBuilderPage(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: false,
      ),
      theme: ThemeData.dark(),
    );
  }
}