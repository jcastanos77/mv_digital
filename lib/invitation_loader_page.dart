import 'package:flutter/material.dart';
import 'package:mv_digital/core/templates/baptism_invitation_page.dart';
import 'package:mv_digital/core/templates/birthday_invitation_page.dart';
import 'package:mv_digital/core/templates/quince_princess_page.dart';
import 'core/templates/spiderman_page.dart' deferred as spiderman;
import 'core/templates/pokemon_page.dart' deferred as pokemon;
import 'core/templates/toy_story_page.dart' deferred as toyStory;
import 'core/templates/wedding_glam.dart' deferred as wedding;
import 'core/templates/quince_glam.dart' deferred as quince;
import 'package:mv_digital/landing/landing_mv_page.dart';
import 'package:mv_digital/models/invitation_model.dart';
import 'package:mv_digital/models/snackBar_model.dart';
import 'package:mv_digital/services/invitation_service.dart';
import 'package:mv_digital/themes/invitation_theme.dart';
import 'package:mv_digital/themes/theme_resolver.dart';

class InvitationLoaderPage extends StatefulWidget {
  final String? slug;

  const InvitationLoaderPage({
    super.key,
    this.slug,
  });

  @override
  State<InvitationLoaderPage> createState() =>
      _InvitationLoaderPageState();
}

class _InvitationLoaderPageState extends State<InvitationLoaderPage> {
  late Future<InvitationModel?>? _invitationFuture;

  @override
  void initState() {
    super.initState();

    final slug = widget.slug;

    /// Solo consultamos Firebase para invitaciones reales.
    /// Los demos no necesitan Firebase.
    if (slug != null &&
        slug.isNotEmpty &&
        !slug.startsWith('demo-')) {
      _invitationFuture = InvitationService().getInvitation(slug);
    } else {
      _invitationFuture = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final slug = widget.slug;

    /// =========================
    /// LANDING
    /// =========================
    if (slug == null || slug.isEmpty) {
      return const LandingPage();
    }

    /// =========================
    /// DEMOS
    /// =========================

    if (slug == "demo-boda") {
      return DeferredTemplateLoader(
        loadLibrary: wedding.loadLibrary,
        builder: () => wedding.WeddingGlamTemplate(
          data: _demoWedding,
          fromPrincipalPage: false,
        ),
      );
    }

    if (slug == "demo-xv") {
      return DeferredTemplateLoader(
        loadLibrary: quince.loadLibrary,
        builder: () => quince.QuinceGlamPage(
          data: _demoXV,
          fromPrincipalPage: false,
        ),
      );
    }

    if (slug == "demo-birthday") {
      return BirthdayInvitationPage(
        data: _demoBirthday,
        theme: resolveBirthdayTheme(
          Uri.base.queryParameters["theme"],
        ),
        fromPrincipalPage: false,
      );
    }

    if (slug == "demo-bautizo") {
      return BaptismGlamPage(
        data: _demoBaptism,
        fromPrincipalPage: false,
      );
    }

    /// =========================
    /// INVITACIÓN REAL
    /// =========================

    return FutureBuilder<InvitationModel?>(
      future: _invitationFuture,
      builder: (context, snapshot) {
        /// LOADING
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        /// ERROR
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                "Error cargando invitación\n${snapshot.error}",
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        /// NO EXISTE
        if (!snapshot.hasData || snapshot.data == null) {
          return const LandingPage();
        }

        final invitation = snapshot.data!;

        /// TEMA
        final InvitationTheme birthdayTheme =
        resolveBirthdayTheme(invitation.theme);

        /// =========================
        /// TEMPLATE
        /// =========================

        switch (invitation.template) {
          case "quince_glam":
            return DeferredTemplateLoader(
              loadLibrary: quince.loadLibrary,
              builder: () => quince.QuinceGlamPage(
                data: invitation,
                fromPrincipalPage: false,
              ),
            );

          case "quince_sin_imagen":
            return QuincePrincessPage(
              data: invitation,
              fromPrincipalPage: false,
            );

          case "wedding_glam":
            return DeferredTemplateLoader(
              loadLibrary: wedding.loadLibrary,
              builder: () => wedding.WeddingGlamTemplate(
                data: invitation,
                fromPrincipalPage: false,
              ),
            );

          case "birthday":
            return BirthdayInvitationPage(
              theme: birthdayTheme,
              data: invitation,
              fromPrincipalPage: false,
            );

          case "toy_story":
            return DeferredTemplateLoader(
              loadLibrary: toyStory.loadLibrary,
              builder: () => toyStory.ToyStoryPage(
                theme: birthdayTheme,
                data: invitation,
                fromPrincipalPage: false,
              ),
            );

          case "baptism_glam":
            return BaptismGlamPage(
              data: invitation,
              fromPrincipalPage: false,
            );

          case "spiderman":
            return DeferredTemplateLoader(
              loadLibrary: spiderman.loadLibrary,
              builder: () => spiderman.SpidermanPage(
                data: invitation,
                fromPrincipalPage: false,
              ),
            );
          case "pokemon":
            return DeferredTemplateLoader(
              loadLibrary: pokemon.loadLibrary,
              builder: () => pokemon.PokemonPage(
                data: invitation,
                fromPrincipalPage: false,
              ),
            );

          default:
            return const LandingPage();
        }
      },
    );
  }
}

class DeferredTemplateLoader extends StatefulWidget {
  final Future<void> Function() loadLibrary;
  final Widget Function() builder;

  const DeferredTemplateLoader({
    super.key,
    required this.loadLibrary,
    required this.builder,
  });

  @override
  State<DeferredTemplateLoader> createState() =>
      _DeferredTemplateLoaderState();
}

class _TemplateLoadingPage extends StatelessWidget {
  const _TemplateLoadingPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _DeferredTemplateLoaderState
    extends State<DeferredTemplateLoader> {

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
          return const _TemplateLoadingPage();
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Error cargando plantilla\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return widget.builder();
      },
    );
  }
}

/// =================================================
/// DEMOS
/// =================================================

/// DEMO XV
final _demoXV = InvitationModel(
  id: "demo_xv",
  template: "quince_glam",
  title: "Sofía",
  theme: '',
  quote: "Hoy celebro mis XV años rodeada de las personas que amo.",
  location: "Salón Imperial",
  heroImage:
  "https://images.unsplash.com/photo-1763959949881-22f1f13cf082?auto=format&fit=crop&w=1200&q=80",
  eventDate: DateTime(2026, 8, 15, 18, 0),
  eventTime: "6:00 PM",
  ceremonyPlace: "Santuario de Guadalupe",
  ceremonyTime: "6:00 PM",
  ceremonyImage: "",
  ceremonyMaps: "https://maps.google.com",
  receptionPlace: "Salón Imperial",
  receptionTime: "8:00 PM",
  receptionImage: "",
  receptionMaps: "https://maps.google.com",
  dressCode: "Formal elegante\nTonos pastel sugeridos",
  gallery: [],
  infoAditional: "",
  snackBar: SnackBarData(
    title: 'Zona de Snacks',
    subtitle:
    'Nuestra tripulación tendrá snacks listos para la misión submarina',
    startTime: '4:00 PM',
    endTime: '8:00 PM',
  ),
);

/// DEMO BAUTIZO
final _demoBaptism = InvitationModel(
  id: "demo_baptism",
  template: "baptism_glam",
  theme: "",
  title: "Romina Alejandra",
  heroImage:
  "https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=1200&q=80",
  eventDate: DateTime(2026, 9, 19, 12, 0),
  eventTime: "12:00 PM",
  infoAditional: "",
  quote:
  "Hoy recibo con alegría el sacramento del Bautismo. Gracias por acompañarme en este día tan especial.",
  location: "Ciudad Obregón, Sonora",
  ceremonyPlace: "Parroquia San Juan Bosco",
  ceremonyTime: "12:00 PM",
  ceremonyImage: "",
  ceremonyMaps: "https://maps.google.com",
  receptionPlace: "Quinta Los Álamos",
  receptionTime: "2:00 PM",
  receptionImage: "",
  receptionMaps: "https://maps.google.com",
  dressCode: "Formal",
  gallery: [],
  father: "Jorge Castaños",
  mother: "Daniela López",
  godParents: [
    "Daniela López",
    "Daniela López",
  ],
  bibleVerse:
  "Dejad que los niños vengan a mí y no se lo impidáis, porque de los que son como ellos es el reino de Dios. — Marcos 10:14",
  snackBar: SnackBarData(
    title: "MV Snacks Bar",
    subtitle:
    "Disfruta de nuestra barra de snacks preparada especialmente para celebrar este gran día.",
    startTime: "2:00 PM",
    endTime: "6:00 PM",
  ),
);

/// DEMO BODA
final _demoWedding = InvitationModel(
  id: "demo_boda",
  template: "wedding_glam",
  theme: '',
  title: "Luis & Ana",
  quote: "El amor no consiste en mirarse el uno al otro...",
  location: "Hacienda Los Olivos",
  heroImage:
  "https://images.unsplash.com/photo-1522673607200-164d1b6ce486?auto=format&fit=crop&w=1600&q=80",
  eventDate: DateTime(2026, 9, 15, 17, 0),
  eventTime: "5:00 PM",
  ceremonyPlace: "Parroquia San José",
  ceremonyTime: "5:00 PM",
  ceremonyImage: "",
  ceremonyMaps: "https://maps.google.com",
  receptionPlace: "Hacienda Los Olivos",
  receptionTime: "8:00 PM",
  receptionImage: "",
  receptionMaps: "https://maps.google.com",
  dressCode: "Formal elegante",
  gallery: [],
  infoAditional: "",
  snackBar: SnackBarData(
    title: 'Zona de Snacks',
    subtitle:
    'Nuestra tripulación tendrá snacks listos para la misión submarina',
    startTime: '4:00 PM',
    endTime: '8:00 PM',
  ),
);

/// DEMO CUMPLEAÑOS
final _demoBirthday = InvitationModel(
  id: "demo_birthday",
  template: "birthday",
  title: "Juan Pérez",
  theme: 'cowboy',
  quote: "Acompáñame a celebrar mis 30 años",
  location: "Rancho Los Compadres",
  heroImage:
  "https://plus.unsplash.com/premium_photo-1737392497549-774709c38e79?q=80&w=1480&auto=format&fit=crop",
  eventDate: DateTime(2026, 7, 10, 19, 0),
  eventTime: "7:00 PM",
  ceremonyPlace: "",
  ceremonyTime: "",
  ceremonyImage: "",
  ceremonyMaps: "",
  receptionPlace: "Rancho Los Compadres",
  receptionTime: "7:00 PM",
  receptionImage: "",
  receptionMaps: "https://maps.google.com",
  dressCode: "Vaquero",
  gallery: [
    "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d",
    "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
    "https://images.unsplash.com/photo-1494790108377-be9c29b29330",
    "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
  ],
  infoAditional: "",
  snackBar: SnackBarData(
    title: 'Zona de Snacks',
    subtitle:
    'Nuestra tripulación tendrá snacks listos para la misión submarina',
    startTime: '4:00 PM',
    endTime: '8:00 PM',
  ),
);