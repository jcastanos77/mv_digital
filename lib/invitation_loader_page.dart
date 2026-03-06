import 'package:flutter/material.dart';
import 'package:mv_digital/core/templates/wedding_glam.dart';
import 'package:mv_digital/services/invitation_service.dart';

import 'core/templates/quince_glam.dart';

class InvitationLoaderPage extends StatelessWidget {

  const InvitationLoaderPage({super.key});

  @override
  Widget build(BuildContext context) {

    final uri = Uri.base;
    final invitationId = uri.pathSegments.last;

    return FutureBuilder(

      future: InvitationService().getInvitation(invitationId),

      builder: (context, snapshot) {

        /// CARGANDO
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        /// ERROR
        if(snapshot.hasError){
          return const Scaffold(
            body: Center(
              child: Text("Error cargando la invitación"),
            ),
          );
        }

        /// NO EXISTE
        if(!snapshot.hasData){
          return const Scaffold(
            body: Center(
              child: Text("Invitación no encontrada"),
            ),
          );
        }

        final invitation = snapshot.data!;

        switch(invitation.template){

          case "quince_glam":
            return QuinceGlamPage(data: invitation);

          case "wedding_glam":
            return WeddingGlamTemplate(data: invitation);

          default:
            return const Scaffold(
              body: Center(
                child: Text("Plantilla no encontrada"),
              ),
            );

        }

      },

    );

  }

}