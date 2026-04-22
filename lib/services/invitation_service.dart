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
    required String theme,

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
      "theme": theme,
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

  Future createInvitationBirthday({
    required String slug,
    required String template,
    required String theme,
    required String title,
    required String heroImage,
    required DateTime eventDate,
    required String location,
    required String mapsUrl,

    String? quote,
    String? ceremonyPlace,
    String? ceremonyTime,
    String? ceremonyImage,
    String? ceremonyMaps,
    String? receptionPlace,
    String? receptionTime,
    String? receptionImage,
    String? receptionMaps,
    String? dressCode,
    List<String>? gallery,
  }) async {

    final docRef = _firestore.collection("invitations").doc(slug);

    final data = {

      /// BASICO
      "slug": slug,
      "template": template,
      "theme": theme,
      "title": title,
      "quote": quote ?? "",
      "heroImage": heroImage,
      "mapsUrl": mapsUrl,
      /// EVENTO
      "eventDate": Timestamp.fromDate(eventDate),
      "location": location,

      /// OPCIONALES (solo si existen)
      if(ceremonyPlace != null) "ceremonyPlace": ceremonyPlace,
      if(ceremonyTime != null) "ceremonyTime": ceremonyTime,
      if(ceremonyImage != null) "ceremonyImage": ceremonyImage,
      if(ceremonyMaps != null) "ceremonyMaps": ceremonyMaps,

      if(receptionPlace != null) "receptionPlace": receptionPlace,
      if(receptionTime != null) "receptionTime": receptionTime,
      if(receptionImage != null) "receptionImage": receptionImage,
      if(receptionMaps != null) "receptionMaps": receptionMaps,
      if(location != null) "location": location,
      if(mapsUrl != null) "mapsUrl": mapsUrl,
      if(dressCode != null) "dressCode": dressCode,

      /// GALERIA
      "gallery": gallery ?? [],

      /// META
      "createdAt": FieldValue.serverTimestamp(),
    };

    await docRef.set(data);
  }


}