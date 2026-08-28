import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'firebase_options.dart';
import 'invitation_loader_page.dart' deferred as invitationLoader;

import 'landing/landing_mv_page.dart';

import 'admin/admin_dashboard.dart' deferred as adminDashboard;
import 'admin/create_invitation_page.dart' deferred as adminCreate;
import 'admin/select_invitation_type_page.dart' deferred as adminSelectType;
import 'admin/create_invitation_birthday.dart' deferred as adminBirthday;
import 'admin/baptism_builder_page.dart' deferred as adminBaptism;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('es');


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  usePathUrlStrategy();

  runApp(const MyApp());
}

final GoRouter router = GoRouter(
  routes: [
    /// LANDING
    GoRoute(
      path: '/',
      builder: (context, state) => const LandingPage(),
    ),

    /// INVITACIONES
    GoRoute(
      path: '/invitation/:slug',
      builder: (context, state) {
        final slug = state.pathParameters['slug']!;

        return DeferredPageLoader(
          loadLibrary: invitationLoader.loadLibrary,
          builder: () => invitationLoader.InvitationLoaderPage(
            slug: slug,
          ),
        );
      },
    ),

    /// DEMOS
    GoRoute(
      path: '/demo/boda',
      builder: (context, state) => DeferredPageLoader(
        loadLibrary: invitationLoader.loadLibrary,
        builder: () => invitationLoader.InvitationLoaderPage(
          slug: 'demo-boda',
        ),
      ),
    ),

    GoRoute(
      path: '/demo/xv',
      builder: (context, state) => DeferredPageLoader(
        loadLibrary: invitationLoader.loadLibrary,
        builder: () => invitationLoader.InvitationLoaderPage(
          slug: 'demo-xv',
        ),
      ),
    ),

    GoRoute(
      path: '/demo/birthday',
      builder: (context, state) => DeferredPageLoader(
        loadLibrary: invitationLoader.loadLibrary,
        builder: () => invitationLoader.InvitationLoaderPage(
          slug: 'demo-birthday',
        ),
      ),
    ),

    GoRoute(
      path: '/demo/bautizo',
      builder: (context, state) => DeferredPageLoader(
        loadLibrary: invitationLoader.loadLibrary,
        builder: () => invitationLoader.InvitationLoaderPage(
          slug: 'demo-bautizo',
        ),
      ),
    ),

    /// ADMIN
    GoRoute(
      path: '/admin',
      builder: (context, state) => DeferredPageLoader(
        loadLibrary: adminDashboard.loadLibrary,
        builder: () => adminDashboard.AdminDashboard(),
      ),
    ),

    GoRoute(
      path: '/admin/create',
      builder: (context, state) => DeferredPageLoader(
        loadLibrary: adminCreate.loadLibrary,
        builder: () => adminCreate.CreateInvitationPage(),
      ),
    ),

    GoRoute(
      path: '/admin/create-birthday',
      builder: (context, state) => DeferredPageLoader(
        loadLibrary: adminBirthday.loadLibrary,
        builder: () => adminBirthday.BirthdayBuilderPage(),
      ),
    ),

    GoRoute(
      path: '/admin/select-type',
      builder: (context, state) => DeferredPageLoader(
        loadLibrary: adminSelectType.loadLibrary,
        builder: () => adminSelectType.SelectInvitationTypePage(),
      ),
    ),

    GoRoute(
      path: '/admin/create-baptism',
      builder: (context, state) => DeferredPageLoader(
        loadLibrary: adminBaptism.loadLibrary,
        builder: () => adminBaptism.BaptismBuilderPage(),
      ),
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

class DeferredPageLoader extends StatefulWidget {
  final Future<void> Function() loadLibrary;
  final Widget Function() builder;

  const DeferredPageLoader({
    super.key,
    required this.loadLibrary,
    required this.builder,
  });

  @override
  State<DeferredPageLoader> createState() => _DeferredPageLoaderState();
}

class _DeferredPageLoaderState extends State<DeferredPageLoader> {
  late Future<void> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.loadLibrary();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('Error cargando página'),
            ),
          );
        }

        return widget.builder();
      },
    );
  }
}