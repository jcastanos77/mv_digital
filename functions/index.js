const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const db = admin.firestore();

exports.registerInvitationVisit = functions
  .region("us-central1")
  .runWith({
    memory: "256MB",
    timeoutSeconds: 30,
  })
  .https.onRequest(async (req, res) => {
    // CORS
    res.set("Access-Control-Allow-Origin", "*");
    res.set("Access-Control-Allow-Methods", "POST, OPTIONS");
    res.set(
      "Access-Control-Allow-Headers",
      "Content-Type"
    );

    // Preflight
    if (req.method === "OPTIONS") {
      return res.status(204).send("");
    }

    if (req.method !== "POST") {
      return res.status(405).json({
        error: "Método no permitido",
      });
    }

    try {
      const invitationId = req.body?.invitationId;
      const visitorId = req.body?.visitorId;

      if (!invitationId || !visitorId) {
        return res.status(400).json({
          error: "Faltan invitationId o visitorId",
        });
      }

      const invitationRef = db
        .collection("invitations")
        .doc(invitationId);

      const visitorRef = invitationRef
        .collection("visitors")
        .doc(visitorId);

      let isNewVisitor = false;

      await db.runTransaction(async (transaction) => {
        const invitationDoc =
            await transaction.get(invitationRef);

        if (!invitationDoc.exists) {
          throw new Error("INVITATION_NOT_FOUND");
        }

        const visitorDoc =
            await transaction.get(visitorRef);

        // Cada entrada cuenta como una vista
        transaction.update(invitationRef, {
          views: admin.firestore.FieldValue.increment(1),
        });

        // Solo aumenta personas únicas si nunca había entrado
        if (!visitorDoc.exists) {
          isNewVisitor = true;

          transaction.set(visitorRef, {
            firstVisit:
                admin.firestore.FieldValue.serverTimestamp(),
          });

          transaction.update(invitationRef, {
            uniqueViews:
                admin.firestore.FieldValue.increment(1),
          });
        }
      });

      return res.status(200).json({
        success: true,
        isNewVisitor,
      });

    } catch (error) {
      console.error(
        "Error registrando visita:",
        error
      );

      if (error.message === "INVITATION_NOT_FOUND") {
        return res.status(404).json({
          error: "Invitación no encontrada",
        });
      }

      return res.status(500).json({
        error: "Error registrando visita",
      });
    }
  });