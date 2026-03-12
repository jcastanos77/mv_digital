import 'package:flutter/material.dart';
import 'package:mv_digital/core/templates/wedding_glam.dart';
import 'package:mv_digital/core/templates/quince_glam.dart';
import 'package:mv_digital/models/invitation_model.dart';
import 'package:mv_digital/services/invitation_service.dart';
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

        switch (invitation.template) {

          case "quince_glam":
            return QuinceGlamPage(data: invitation);

          case "wedding_glam":
            return WeddingGlamTemplate(data: invitation);

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