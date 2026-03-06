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

}