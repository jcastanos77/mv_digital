import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mv_digital/core/templates/quince_glam.dart';
import 'package:mv_digital/core/templates/wedding_glam.dart';
import '../core/templates/birthday_invitation_page.dart';
import '../core/widgets/demo_card.dart';
import '../models/invitation_model.dart';
import '../themes/theme_resolver.dart';

class DemoSection extends StatelessWidget {
   DemoSection({super.key});

   final demoWedding = InvitationModel(
     id: "demo_boda",
     template: "wedding_glam",
     theme: '',
     /// HERO
     title: "Luis & Ana",
     heroImage:
     "https://images.unsplash.com/photo-1522673607200-164d1b6ce486?auto=format&fit=crop&w=1600&q=80",
     eventDate: DateTime(2026, 8, 15, 17, 0),
     eventTime: "5:00 PM",

     /// FRASE
     quote:
     "El amor no consiste en mirarse el uno al otro, sino en mirar juntos en la misma dirección.",

     /// UBICACION GENERAL
     location: "Hacienda Los Olivos",

     /// CEREMONIA
     ceremonyPlace: "Parroquia San José",
     ceremonyTime: "5:00 PM",
     ceremonyImage:
     "https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=1400&q=80",
     ceremonyMaps:
     "https://www.google.com/maps/place/Santuario+de+Guadalupe/@27.4898127,-109.9390803",

     /// RECEPCION
     receptionPlace: "Hacienda Los Olivos",
     receptionTime: "8:00 PM",
     receptionImage:
     "https://images.unsplash.com/photo-1520854221256-17451cc331bf?auto=format&fit=crop&w=1400&q=80",
     receptionMaps:
     "https://www.google.com/maps/place/LA+ROCA+JARDIN+DE+EVENTOS/@27.554048,-109.926438",

     /// DRESS CODE
     dressCode: "Formal Elegante",

     /// GALERIA
     gallery: [
       "https://images.unsplash.com/photo-1606800052052-a08af7148866?auto=format&fit=crop&w=1200&q=80",
       "https://images.unsplash.com/photo-1523438885200-e635ba2c371e?auto=format&fit=crop&w=1200&q=80",
       "https://images.unsplash.com/photo-1529636798458-92182e662485?auto=format&fit=crop&w=1200&q=80",
     ],
   );

   final demoXV = InvitationModel(
     id: "demo_xv",
     template: "quince_glam",
     theme: '',
     /// HERO
     title: "Sofía",
     heroImage:
     "https://images.unsplash.com/photo-1763959949881-22f1f13cf082?auto=format&fit=crop&w=1200&q=80",
     eventDate: DateTime(2026, 8, 15, 18, 0),
     eventTime: "6:00 PM",

     /// FRASE
     quote: "Hoy celebro mis XV años rodeada de las personas que más amo.",

     /// UBICACION GENERAL
     location: "Salón Imperial",

     /// CEREMONIA
     ceremonyPlace: "Parroquia San José",
     ceremonyTime: "6:00 PM",
     ceremonyImage:
     "https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=1200&q=80",
     ceremonyMaps:
     "https://www.google.com/maps/place/Santuario+de+Guadalupe/@27.4898127,-109.9390803",

     /// RECEPCION
     receptionPlace: "Salón Imperial",
     receptionTime: "8:00 PM",
     receptionImage:
     "https://images.unsplash.com/photo-1520854221256-17451cc331bf?auto=format&fit=crop&w=1200&q=80",
     receptionMaps:
     "https://www.google.com/maps/place/LA+ROCA+JARDIN+DE+EVENTOS/@27.554048,-109.926438",

     /// DRESS CODE
     dressCode: "Formal Elegante",

     /// GALERIA
     gallery: [
       "https://images.unsplash.com/photo-1763959951409-430bfebd5515?auto=format&fit=crop&w=1200&q=80",
       "https://images.unsplash.com/photo-1763959944953-d8f723c34bff?auto=format&fit=crop&w=1200&q=80",
       "https://images.unsplash.com/photo-1656918839048-cd1c3df3c0e9?auto=format&fit=crop&w=1200&q=80",
     ],
   );

   final _demoB= InvitationModel(
     id: "demo_birthday",
     template: "birthday",
     theme: 'cowboy',
     title: "Juan Pérez",
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

  @override
  Widget build(BuildContext context) {

    bool isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 100 : 180,
        horizontal: isMobile ? 20 : 40,
      ),
      child: Column(
        children: [

          /// TITULO
          Text(
            "Explora una invitación real",
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 36 : 60,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "Diseños elegantes para bodas y XV años",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 16 : 20,
              color: Colors.white70,
            ),
          ),

          SizedBox(height: isMobile ? 60 : 120),

          /// DEMOS
          LayoutBuilder(
            builder: (context, constraints) {

              bool isMobile = constraints.maxWidth < 900;

              if (isMobile) {
                return Column(
                  children: [
                    _demoBoda(context),
                    const SizedBox(height: 60),
                    _demoXV(context),
                    const SizedBox(height: 60),
                    _demoBirthday(context)
                  ],
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  _demoBoda(context),

                  const SizedBox(width: 80),

                  _demoXV(context),

                  const SizedBox(width: 80),

                  _demoBirthday(context)

                ],
              );
            },
          )

        ],
      ),
    );
  }

   Widget _demoBoda(BuildContext context) {

     return DemoCard(
       title: "Boda",
       image: "assets/bodademo.jpeg",
       onTap: () {
         Navigator.push(
           context,
           MaterialPageRoute(
             builder: (_) => WeddingGlamTemplate(data: demoWedding),
           ),
         );
       },
     );
   }

   Widget _demoXV(BuildContext context) {

     return DemoCard(
       title: "XV",
       image: "assets/xvdemo.jpeg",
       onTap: () {
         Navigator.push(
           context,
           MaterialPageRoute(
             builder: (_) => QuinceGlamPage(data: demoXV),
           ),
         );
       },
     );
   }

   Widget _demoBirthday(BuildContext context) {

     return DemoCard(
       title: "Cumpleaños",
       image: "assets/vaquero.jpg",
       onTap: () {
         Navigator.push(
           context,
           MaterialPageRoute(
             builder: (_) => BirthdayInvitationPage(
               data: _demoB,
               theme: resolveBirthdayTheme(
                 Uri.base.queryParameters["theme"],
               ),
             ),
           ),
         );
       },
     );
   }
}