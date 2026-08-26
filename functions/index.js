const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const db = admin.firestore();

exports.invitationPreview = functions
  .region("us-central1")
  .runWith({
    memory: "512MB",
    timeoutSeconds: 60,
  })
  .https.onRequest(async (req, res) => {
    try {
      const slug = req.query.slug;

      if (!slug) {
        return res.status(400).send("Falta el slug de la invitación");
      }

      const doc = await db
        .collection("invitations")
        .doc(slug)
        .get();

      if (!doc.exists) {
        return res.status(404).send("Invitación no encontrada");
      }

      const data = doc.data();

      const name = data.title || "Invitación";
      const heroImage = data.heroImage || "";
      const template = data.template || "";

      let pageTitle = `Invitación de ${name}`;
      let description =
        "Te invitamos a compartir este día tan especial.";

      if (template === "birthday") {
        pageTitle = `Cumpleaños de ${name} 🎉`;
        description = `¡Estás invitado a celebrar el cumpleaños de ${name}!`;
      }

      if (template === "spiderman") {
        pageTitle = `Cumpleaños de ${name} 🕷️`;
        description = `¡Acompaña a ${name} en esta increíble aventura!`;
      }

      if (template === "baptism") {
        pageTitle = `Bautizo de ${name}`;
        description = `Acompáñanos a celebrar el bautizo de ${name}.`;
      }

      if (template === "quince_glam") {
        pageTitle = `XV años de ${name}`;
        description = `Acompáñanos a celebrar los XV años de ${name}.`;
      }

      if (template === "wedding_glam") {
        pageTitle = name;
        description =
          "Nos encantará compartir contigo este día tan especial.";
      }

      const invitationUrl =
        `https://mvdigital-1befe.web.app/invitation/${slug}`;

      const html = `
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">

  <title>${escapeHtml(pageTitle)}</title>

  <meta property="og:title" content="${escapeHtml(pageTitle)}">
  <meta property="og:description" content="${escapeHtml(description)}">
  <meta property="og:image" content="${escapeHtml(heroImage)}">
  <meta property="og:url" content="${escapeHtml(invitationUrl)}">
  <meta property="og:type" content="website">
  <meta property="og:site_name" content="MV Digital">

  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="${escapeHtml(pageTitle)}">
  <meta name="twitter:description" content="${escapeHtml(description)}">
  <meta name="twitter:image" content="${escapeHtml(heroImage)}">
</head>

<body>
  <h1>${escapeHtml(pageTitle)}</h1>
</body>
</html>
`;

      return res
        .status(200)
        .set("Content-Type", "text/html; charset=utf-8")
        .send(html);

    } catch (error) {
      console.error("Error generando preview:", error);

      return res
        .status(500)
        .send("Error generando preview");
    }
  });

function escapeHtml(value) {
  return String(value)
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
}