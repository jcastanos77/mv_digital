import 'package:flutter/material.dart';
import 'package:mv_digital/core/templates/birthday_invitation_page.dart';
import 'package:mv_digital/core/templates/wedding_glam.dart';
import 'package:mv_digital/core/templates/quince_glam.dart';
import 'package:mv_digital/models/invitation_model.dart';
import 'package:mv_digital/services/invitation_service.dart';
import 'package:mv_digital/themes/invitation_theme.dart';
import 'package:mv_digital/themes/theme_resolver.dart';
import 'landing/landing_mv_page.dart';

class InvitationLoaderPage extends StatelessWidget {

  final String? slug;

  const InvitationLoaderPage({super.key, this.slug});

  @override
  Widget build(BuildContext context) {

    /// LANDING
    if (slug == null || slug!.isEmpty) {
      return const LandingPage();
    }

    /// DEMOS
    if (slug == "demo-boda") {
      return WeddingGlamTemplate(data: _demoWedding);
    }

    if (slug == "demo-xv") {
      return QuinceGlamPage(data: _demoXV);
    }

    if (slug == "demo-birthday") {
      return BirthdayInvitationPage(
        data: _demoBirthday,
        theme: resolveBirthdayTheme(
          Uri.base.queryParameters["theme"],
        ),
      );
    }

    /// INVITACION REAL
    return FutureBuilder<InvitationModel?>(
      future: InvitationService().getInvitation(slug!),
      builder: (context, snapshot) {

        /// LOADING
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        /// ERROR
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error cargando invitación\n${snapshot.error}"),
            ),
          );
        }

        /// NO EXISTE
        if (!snapshot.hasData || snapshot.data == null) {
          return const LandingPage();
        }

        final invitation = snapshot.data!;
        final uri = Uri.base;
        InvitationTheme birthdayTheme = resolveBirthdayTheme(invitation.theme);

        switch (invitation.template) {

          case "quince_glam":
            return QuinceGlamPage(data: invitation);

          case "wedding_glam":
            return WeddingGlamTemplate(data: invitation);

          case "birthday":
            return BirthdayInvitationPage(
              theme: birthdayTheme,
              data: invitation,
            );

          default:
            return const LandingPage();
        }

      },
    );
  }
}

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
);

final _demoBirthday = InvitationModel(
  id: "demo_birthday",
  template: "birthday",
  title: "Juan Pérez",
  theme: 'cowboy',
  quote: "Acompáñame a celebrar mis 30 años",
  location: "Rancho Los Compadres",
  heroImage: "https://plus.unsplash.com/premium_photo-1737392497549-774709c38e79?q=80&w=1480&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
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
);