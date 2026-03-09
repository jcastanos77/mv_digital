import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'admin/admin_dashboard.dart';
import 'admin/create_invitation_page.dart';
import 'firebase_options.dart';
import 'invitation_loader_page.dart';
import 'landing/landing_mv_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  usePathUrlStrategy();

  runApp(const MyApp());
}

final GoRouter router = GoRouter(

  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LandingPage(),
    ),

    GoRoute(
      path: '/demo/boda',
      builder: (context, state) => InvitationLoaderPage(slug: "demo-boda"),
    ),

    GoRoute(
      path: '/demo/xv',
      builder: (context, state) => InvitationLoaderPage(slug: "demo-xv"),
    ),

    GoRoute(
      path: '/invitation/:slug',
      builder: (context, state) {

        final slug = state.pathParameters['slug'];

        return InvitationLoaderPage(slug: slug);
      },
    ),

    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminDashboard(),
    ),

    GoRoute(
      path: '/admin/create',
      builder: (context, state) => const CreateInvitationPage(),
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
      theme: ThemeData.dark(),
    );
  }
}