import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/invitation_model.dart';

class InvitationService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<InvitationModel?> getInvitation(String id) async {

    final doc = await _firestore
        .collection("invitations")
        .doc(id)
        .get();

    if(!doc.exists) return null;

    return InvitationModel.fromMap(
      doc.id,
      doc.data()!,
    );

  }

  Future createInvitation({

    required String slug,
    required String template,

    required String title,
    required String heroImage,
    required DateTime eventDate,

    required String quote,
    required String location,

    required String ceremonyPlace,
    required String ceremonyTime,
    required String ceremonyImage,
    required String ceremonyMaps,

    required String receptionPlace,
    required String receptionTime,
    required String receptionImage,
    required String receptionMaps,

    required String dressCode,

    required List<String> gallery,

  }) async {

    await _firestore.collection("invitations").doc(slug).set({

      /// TEMPLATE
      "template": template,

      /// HERO
      "title": title,
      "heroImage": heroImage,
      "eventDate": eventDate,
      "eventTime": "",

      /// QUOTE
      "quote": quote,

      /// LOCATION
      "location": location,

      /// CEREMONIA
      "ceremonyPlace": ceremonyPlace,
      "ceremonyTime": ceremonyTime,
      "ceremonyImage": ceremonyImage,
      "ceremonyMaps": ceremonyMaps,

      /// RECEPCION
      "receptionPlace": receptionPlace,
      "receptionTime": receptionTime,
      "receptionImage": receptionImage,
      "receptionMaps": receptionMaps,

      /// DRESS CODE
      "dressCode": dressCode,

      /// GALERIA
      "gallery": gallery,

      /// METADATA
      "createdAt": FieldValue.serverTimestamp(),

    });

  }

}