import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

import 'package:mv_digital/services/invitation_service.dart';

class BaptismBuilderPage extends StatefulWidget {
  const BaptismBuilderPage({super.key});

  @override
  State<BaptismBuilderPage> createState() => _BaptismBuilderPageState();
}

class _BaptismBuilderPageState extends State<BaptismBuilderPage> {

  ///==============================
  /// INFORMACIÓN
  ///==============================

  final nameCtrl = TextEditingController();
  final phraseCtrl = TextEditingController();

  ///==============================
  /// CEREMONIA
  ///==============================

  final ceremonyPlaceCtrl = TextEditingController();
  final ceremonyMapsCtrl = TextEditingController();

  ///==============================
  /// RECEPCIÓN
  ///==============================

  final receptionPlaceCtrl = TextEditingController();
  final receptionMapsCtrl = TextEditingController();

  ///==============================
  /// PAPÁS
  ///==============================

  final fatherCtrl = TextEditingController();
  final motherCtrl = TextEditingController();

  ///==============================
  /// PADRINOS
  ///==============================

  final godFatherCtrl = TextEditingController();
  final godMotherCtrl = TextEditingController();

  ///==============================
  /// VERSÍCULO
  ///==============================

  final bibleVerseCtrl = TextEditingController();

  ///==============================
  /// SNACK BAR
  ///==============================

  final snackTitleCtrl = TextEditingController();
  final snackSubtitleCtrl = TextEditingController();
  final snackStartCtrl = TextEditingController();
  final snackEndCtrl = TextEditingController();

  ///==============================
  /// PICKERS
  ///==============================

  final picker = ImagePicker();

  Uint8List? heroImage;
  List<Uint8List> galleryImages = [];

  String heroUrl = "";
  List<String> galleryUrls = [];

  ///==============================
  /// FECHAS
  ///==============================

  DateTime? selectedDate;

  TimeOfDay? ceremonyTime;
  TimeOfDay? receptionTime;

  ///==============================
  /// GENERAL
  ///==============================

  bool loading = false;
  String slug = "";

  /// ===============================
  /// PICKERS
  /// ===============================

  Future<void> pickHero() async {
    final file = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (file == null) return;

    heroImage = await file.readAsBytes();

    setState(() {});
  }

  Future<void> pickGallery() async {
    final files = await picker.pickMultiImage();

    if (files.isEmpty) return;

    galleryImages.clear();

    for (final file in files) {
      galleryImages.add(await file.readAsBytes());
    }

    setState(() {});
  }

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );

    if (date != null) {
      selectedDate = date;
      setState(() {});
    }
  }

  Future<void> pickCeremonyTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      ceremonyTime = time;
      setState(() {});
    }
  }

  Future<void> pickReceptionTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      receptionTime = time;
      setState(() {});
    }
  }

  /// ===============================
  /// IMAGE
  /// ===============================

  Future<Uint8List> resizeImage(Uint8List bytes,
      int width,) async {
    final decoded = img.decodeImage(bytes)!;

    final resized = img.copyResize(
      decoded,
      width: width,
    );

    final jpg = img.encodeJpg(
      resized,
      quality: 80,
    );

    return Uint8List.fromList(jpg);
  }

  /// ===============================
  /// DATE
  /// ===============================

  DateTime getEventDate() {
    if (selectedDate == null || ceremonyTime == null) {
      return DateTime.now();
    }

    return DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      ceremonyTime!.hour,
      ceremonyTime!.minute,
    );
  }

  /// ===============================
  /// STORAGE
  /// ===============================

  Future<void> uploadHero() async {
    if (heroImage == null) return;

    final resized = await resizeImage(heroImage!, 1200);

    final ref = FirebaseStorage.instance
        .ref()
        .child("baptism/$slug/hero.jpg");

    await ref.putData(resized);

    heroUrl = await ref.getDownloadURL();
  }

  Future<void> uploadGallery() async {
    galleryUrls.clear();

    await Future.wait(
      galleryImages
          .asMap()
          .entries
          .map((entry) async {
        final index = entry.key;
        final bytes = entry.value;

        final resized = await resizeImage(bytes, 1200);

        final ref = FirebaseStorage.instance
            .ref()
            .child("baptism/$slug/gallery/$index.jpg");

        await ref.putData(resized);

        galleryUrls.add(
          await ref.getDownloadURL(),
        );
      }),
    );
  }

  Future<void> createInvitation() async {

    if (nameCtrl.text.trim().isEmpty) {
      _showError("Ingresa el nombre.");
      return;
    }

    if (selectedDate == null) {
      _showError("Selecciona la fecha.");
      return;
    }

    if (ceremonyTime == null) {
      _showError("Selecciona la hora de la ceremonia.");
      return;
    }

    if (ceremonyPlaceCtrl.text.trim().isEmpty) {
      _showError("Ingresa el lugar de la ceremonia.");
      return;
    }

    if (heroImage == null) {
      _showError("Selecciona una imagen principal.");
      return;
    }

    setState(() => loading = true);

    try {

      slug = generateSlug(nameCtrl.text);

      await uploadHero();
      await uploadGallery();

      await InvitationService().createInvitationBaptism(
        slug: slug,
        template: "baptism_glam",
        theme: "glam",

        title: nameCtrl.text.trim(),
        heroImage: heroUrl,
        quote: phraseCtrl.text.trim(),

        eventDate: getEventDate(),

        ceremonyPlace: ceremonyPlaceCtrl.text.trim(),
        ceremonyTime: ceremonyTime!.format(context),
        ceremonyMaps: ceremonyMapsCtrl.text.trim(),

        receptionPlace: receptionPlaceCtrl.text.trim(),
        receptionTime: receptionTime?.format(context) ?? "",
        receptionMaps: receptionMapsCtrl.text.trim(),

        father: fatherCtrl.text.trim(),
        mother: motherCtrl.text.trim(),

        godFather: godFatherCtrl.text.trim(),
        godMother: godMotherCtrl.text.trim(),

        bibleVerse: bibleVerseCtrl.text.trim(),

        gallery: galleryUrls,

        snackBar: {
          "image": "assets/snacks/mv_snacks.jpg",
          "title": snackTitleCtrl.text.trim(),
          "subtitle": snackSubtitleCtrl.text.trim(),
          "startTime": snackStartCtrl.text.trim(),
          "endTime": snackEndCtrl.text.trim(),
          "items": [
            "Gomitas",
            "Frutas",
            "Verduras",
            "Sabritas",
          ],
        },
      );

      if (!mounted) return;

      context.go("/invitation/$slug");

    } catch (e) {

      if (!mounted) return;

      _showError(e.toString());

    } finally {

      if (mounted) {
        setState(() => loading = false);
      }

    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  /// ===============================
  /// SLUG
  /// ===============================

  String generateSlug(String name) {
    final base = name
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .replaceAll(' ', '-');

    final unique = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString()
        .substring(8);

    return "$base-bautizo-$unique";
  }

  @override
  Widget build(BuildContext context) {
    const champagne = Color(0xFF6B4A2F);
    const bg = Color(0xFFF5F5F5);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        title: Text(
          "Nuevo Bautizo",
          style: GoogleFonts.playfairDisplay(
            color: champagne,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _generalSection(),

            const SizedBox(height: 35),

            _ceremonySection(),

            const SizedBox(height: 35),

            _receptionSection(),

            const SizedBox(height: 35),

            _parentsSection(),

            const SizedBox(height: 35),

            _godParentsSection(),

            const SizedBox(height: 35),

            _bibleVerseSection(),

            const SizedBox(height: 35),

            _snackBarSection(),

            const SizedBox(height: 35),

            _gallerySection(),

            const SizedBox(height: 40),

            _createButton(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _generalSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Información principal",
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 25),

            _input(
              "Nombre del niño(a)",
              nameCtrl,
            ),

            _input(
              "Frase o mensaje",
              phraseCtrl,
              maxLines: 3,
            ),

            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: pickDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                selectedDate == null
                    ? "Seleccionar fecha"
                    : "${selectedDate!.day}/${selectedDate!
                    .month}/${selectedDate!.year}",
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton.icon(
              onPressed: pickHero,
              icon: const Icon(Icons.image),
              label: const Text(
                "Seleccionar imagen principal",
              ),
            ),

            const SizedBox(height: 20),

            if (heroImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.memory(
                  heroImage!,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _ceremonySection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                const Icon(
                  Icons.church,
                  color: Color(0xFF6B4A2F),
                ),

                const SizedBox(width: 10),

                Text(
                  "Ceremonia",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            _input(
              "Nombre de la iglesia",
              ceremonyPlaceCtrl,
            ),

            _input(
              "Google Maps",
              ceremonyMapsCtrl,
            ),

            ElevatedButton.icon(
              onPressed: pickCeremonyTime,
              icon: const Icon(Icons.access_time),
              label: Text(
                ceremonyTime == null
                    ? "Seleccionar hora"
                    : ceremonyTime!.format(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _receptionSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                const Icon(
                  Icons.celebration,
                  color: Color(0xFF6B4A2F),
                ),

                const SizedBox(width: 10),

                Text(
                  "Recepción",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            _input(
              "Lugar de la recepción",
              receptionPlaceCtrl,
            ),

            _input(
              "Google Maps",
              receptionMapsCtrl,
            ),

            ElevatedButton.icon(
              onPressed: pickReceptionTime,
              icon: const Icon(Icons.access_time),
              label: Text(
                receptionTime == null
                    ? "Seleccionar hora"
                    : receptionTime!.format(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _parentsSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                const Icon(
                  Icons.family_restroom,
                  color: Color(0xFF6B4A2F),
                ),

                const SizedBox(width: 10),

                Text(
                  "Papás",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Row(
              children: [

                Expanded(
                  child: _input(
                    "Papá",
                    fatherCtrl,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: _input(
                    "Mamá",
                    motherCtrl,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _godParentsSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                const Icon(
                  Icons.volunteer_activism,
                  color: Color(0xFF6B4A2F),
                ),

                const SizedBox(width: 10),

                Text(
                  "Padrinos",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Row(
              children: [

                Expanded(
                  child: _input(
                    "Padrino",
                    godFatherCtrl,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: _input(
                    "Madrina",
                    godMotherCtrl,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _bibleVerseSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                const Icon(
                  Icons.menu_book,
                  color: Color(0xFF6B4A2F),
                ),

                const SizedBox(width: 10),

                Text(
                  "Versículo",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            TextField(
              controller: bibleVerseCtrl,
              minLines: 4,
              maxLines: 6,
              decoration: InputDecoration(
                hintText:
                "Ej. Dejad que los niños vengan a mí...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _snackBarSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                const Icon(
                  Icons.fastfood,
                  color: Color(0xFF6B4A2F),
                ),

                const SizedBox(width: 10),

                Text(
                  "Barra de Snacks",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            _input(
              "Título",
              snackTitleCtrl,
            ),

            _input(
              "Descripción",
              snackSubtitleCtrl,
              maxLines: 2,
            ),

            Row(
              children: [

                Expanded(
                  child: _input(
                    "Hora inicio",
                    snackStartCtrl,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: _input(
                    "Hora final",
                    snackEndCtrl,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _gallerySection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                const Icon(
                  Icons.photo_library,
                  color: Color(0xFF6B4A2F),
                ),

                const SizedBox(width: 10),

                Text(
                  "Galería",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            ElevatedButton.icon(
              onPressed: pickGallery,
              icon: const Icon(Icons.add_photo_alternate),
              label: const Text(
                "Seleccionar imágenes",
              ),
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: galleryImages.map((img) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.memory(
                    img,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: loading ? null : createInvitation,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6B4A2F),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: loading
            ? const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
            : const Text(
          "Crear invitación",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _input(String label,
      TextEditingController controller, {
        int maxLines = 1,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}