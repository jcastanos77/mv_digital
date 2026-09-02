import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class InvitationViewsService {
  static const _visitorIdKey = 'mv_digital_visitor_id';

  static Future<void> registerVisit(String invitationId) async {
    try {
      final visitorId = await _getVisitorId();

      final firestore = FirebaseFirestore.instance;

      final invitationRef = firestore
          .collection('invitations')
          .doc(invitationId);

      final visitorRef = invitationRef
          .collection('visitors')
          .doc(visitorId);

      await firestore.runTransaction((transaction) async {
        final visitorSnapshot =
        await transaction.get(visitorRef);

        final updates = <String, dynamic>{
          'views': FieldValue.increment(1),
        };

        if (!visitorSnapshot.exists) {
          transaction.set(visitorRef, {
            'createdAt': FieldValue.serverTimestamp(),
          });

          updates['uniqueViews'] =
              FieldValue.increment(1);
        }

        transaction.update(
          invitationRef,
          updates,
        );
      });

      print('Visita registrada correctamente');
    } catch (e, stackTrace) {
      print('Error registrando visita: $e');
      print(stackTrace);
    }
  }

  static Future<String> _getVisitorId() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final existingId =
      prefs.getString(_visitorIdKey);

      if (existingId != null && existingId.isNotEmpty) {
        return existingId;
      }

      final newId = const Uuid().v4();

      await prefs.setString(
        _visitorIdKey,
        newId,
      );

      return newId;
    } catch (e) {
      /// Si Safari falla guardando SharedPreferences,
      /// generamos uno temporal para no bloquear
      /// las vistas totales.
      return const Uuid().v4();
    }
  }
}