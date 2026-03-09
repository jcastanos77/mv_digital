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
    required String ceremonyPlace,
    required String receptionPlace,
    required String dressCode,
  }) async {

    await _firestore.collection("invitations").doc(slug).set({

      "template": template,
      "title": title,
      "heroImage": heroImage,
      "eventDate": eventDate.toIso8601String(),

      "ceremonyPlace": ceremonyPlace,
      "receptionPlace": receptionPlace,

      "dressCode": dressCode,

      "gallery": []

    });

  }

}