const express = require("express");
const admin = require("firebase-admin");

admin.initializeApp();

const db = admin.firestore();
const app = express();

app.get("/invitation/:slug", async (req, res) => {
  try {
    const { slug } = req.params;

    console.log("Buscando invitación:", slug);

    const doc = await db
      .collection("invitations")
      .doc(slug)
      .get();

    if (!doc.exists) {
      console.log("Invitación no encontrada");

      return res.status(404).send(`
        <!DOCTYPE html>
        <html lang="es">
          <head>
            <meta charset="UTF-8">
            <title>Invitación no encontrada</title>
          </head>
          <body>
            <h1>Invitación no encontrada</h1>
          </body>
        </html>
      `);
    }

    const data = doc.data();

    console.log("Invitación encontrada:", data);

    const name = data.title || data.name || "Invitación";
    const heroImage = data.heroImage || "";
    const template = data.template || "";

    let pageTitle = `Invitación de ${name}`;
    let description =
      "Te invitamos a compartir este día tan especial.";

    // ─────────────────────────────────────────────
    // CUMPLEAÑOS
    // ─────────────────────────────────────────────

    if (template === "birthday") {
      pageTitle = `Cumpleaños de ${name} 🎉`;
      description =
        `¡Estás invitado a celebrar el cumpleaños de ${name}!`;
    }

    // ─────────────────────────────────────────────
    // SPIDERMAN
    // ─────────────────────────────────────────────

    if (template === "spiderman") {
      pageTitle = `Cumpleaños de ${name} 🕷️`;
      description =
        `¡Acompáñanos a celebrar el cumpleaños de ${name}!`;
    }

    // ─────────────────────────────────────────────
    // MARIO BROS
    // ─────────────────────────────────────────────

    if (template === "mario_bros") {
      pageTitle = `Cumpleaños de ${name} 🎮`;
      description =
        `¡Prepárate para una gran aventura! Acompáñanos a celebrar el cumpleaños de ${name}.`;
    }

    // ─────────────────────────────────────────────
    // BAUTIZO
    // ─────────────────────────────────────────────

    if (template === "baptism") {
      pageTitle = `Bautizo de ${name}`;
      description =
        `Acompáñanos a celebrar el bautizo de ${name}.`;
    }

    // ─────────────────────────────────────────────
    // XV AÑOS
    // ─────────────────────────────────────────────

    if (
      template === "quince_glam" ||
      template === "quince_sin_imagen"
    ) {
      pageTitle = `XV años de ${name}`;
      description =
        `Acompáñanos a celebrar los XV años de ${name}.`;
    }

    // ─────────────────────────────────────────────
    // BODA
    // ─────────────────────────────────────────────

    if (template === "wedding_glam") {
      pageTitle = name;
      description =
        "Nos encantará compartir contigo este día tan especial.";
    }

    // ─────────────────────────────────────────────
    // URL PÚBLICA
    // ─────────────────────────────────────────────

    const previewUrl =
      `https://mvdigital.cc/invitation/${slug}`;

    // ─────────────────────────────────────────────
    // URL DE LA APP FLUTTER
    // ─────────────────────────────────────────────

    const appUrl =
      `https://mvdigital.cc/invitation/${slug}`;

    // ─────────────────────────────────────────────
    // HTML
    // ─────────────────────────────────────────────

    const html = `
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">

  <meta
    property="og:title"
    content="${escapeHtml(pageTitle)}"
  >

  <meta
    property="og:description"
    content="${escapeHtml(description)}"
  >

  <meta
    property="og:image"
    content="${escapeHtml(heroImage)}"
  >

  <meta
    property="og:url"
    content="${escapeHtml(previewUrl)}"
  >

  <meta
    property="og:type"
    content="website"
  >

  <meta
    property="og:site_name"
    content="MV Digital"
  >

  <meta
    name="twitter:card"
    content="summary_large_image"
  >

  <meta
    name="twitter:title"
    content="${escapeHtml(pageTitle)}"
  >

  <meta
    name="twitter:description"
    content="${escapeHtml(description)}"
  >

  <meta
    name="twitter:image"
    content="${escapeHtml(heroImage)}"
  >

  <title>${escapeHtml(pageTitle)}</title>

  <script>
    window.location.replace("${appUrl}");
  </script>
</head>

<body>
  <p>Abriendo invitación...</p>
</body>
</html>
`;

    return res
      .status(200)
      .set("Content-Type", "text/html; charset=utf-8")
      .send(html);

  } catch (error) {
    console.error("ERROR:", error);

    return res.status(500).send(`
      <h1>Error generando preview</h1>
      <pre>${escapeHtml(error.message)}</pre>
    `);
  }
});

// ─────────────────────────────────────────────
// SERVER
// ─────────────────────────────────────────────

const port = process.env.PORT || 8080;

app.listen(port, () => {
  console.log(`Preview server running on port ${port}`);
});

// ─────────────────────────────────────────────
// ESCAPE HTML
// ─────────────────────────────────────────────

function escapeHtml(value) {
  return String(value)
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
}