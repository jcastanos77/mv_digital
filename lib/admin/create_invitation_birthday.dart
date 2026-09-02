import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:go_router/go_router.dart';

import 'package:mv_digital/services/invitation_service.dart';

class BirthdayBuilderPage extends StatefulWidget {
  const BirthdayBuilderPage({super.key});

  @override
  State<BirthdayBuilderPage> createState() =>
      _BirthdayBuilderPageState();
}

class _BirthdayBuilderPageState
    extends State<BirthdayBuilderPage> {

  /// ============================================
  /// CONTROLLERS
  /// ============================================

  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final phraseCtrl = TextEditingController();

  final placeCtrl = TextEditingController();
  final mapsCtrl = TextEditingController();

  final snackTitleCtrl = TextEditingController();
  final snackSubtitleCtrl = TextEditingController();
  final snackStartCtrl = TextEditingController();
  final snackEndCtrl = TextEditingController();

  /// ============================================
  /// TEMPLATE
  /// ============================================

  String selectedTemplate = "birthday";

  /// Solo se utiliza para birthday clásico
  String selectedTheme = "cowboy";

  /// ============================================
  /// IMÁGENES
  /// ============================================

  final picker = ImagePicker();

  Uint8List? heroImage;
  final List<Uint8List> galleryImages = [];

  String heroUrl = "";
  final List<String> galleryUrls = [];

  /// ============================================
  /// GENERAL
  /// ============================================

  bool loading = false;

  String slug = "";

  TimeOfDay? eventTime;
  DateTime? selectedDate;

  /// ============================================
  /// DISPOSE
  /// ============================================

  @override
  void dispose() {
    nameCtrl.dispose();
    ageCtrl.dispose();
    phraseCtrl.dispose();

    placeCtrl.dispose();
    mapsCtrl.dispose();

    snackTitleCtrl.dispose();
    snackSubtitleCtrl.dispose();
    snackStartCtrl.dispose();
    snackEndCtrl.dispose();

    super.dispose();
  }

  /// ============================================
  /// PICK HERO
  /// ============================================

  Future<void> pickHero() async {
    final file = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (file == null) return;

    heroImage = await file.readAsBytes();

    if (mounted) {
      setState(() {});
    }
  }

  /// ============================================
  /// PICK GALLERY
  /// ============================================

  Future<void> pickGallery() async {
    final files = await picker.pickMultiImage();

    if (files.isEmpty) return;

    for (final file in files) {
      galleryImages.add(
        await file.readAsBytes(),
      );
    }

    if (mounted) {
      setState(() {});
    }
  }

  /// ============================================
  /// PICK DATE
  /// ============================================

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );

    if (date == null) return;

    setState(() {
      selectedDate = date;
    });
  }

  /// ============================================
  /// PICK TIME
  /// ============================================

  Future<void> pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    setState(() {
      eventTime = time;
    });
  }

  /// ============================================
  /// RESIZE
  /// ============================================

  Future<Uint8List> resizeImage(
      Uint8List bytes,
      int width,
      ) async {
    final decoded = img.decodeImage(bytes);

    if (decoded == null) {
      throw Exception(
        "No se pudo procesar la imagen.",
      );
    }

    final resized = img.copyResize(
      decoded,
      width: width,
    );

    final jpg = img.encodeJpg(
      resized,
      quality: 75,
    );

    return Uint8List.fromList(jpg);
  }

  /// ============================================
  /// FECHA FINAL
  /// ============================================

  DateTime getFinalDateTime() {
    if (selectedDate == null ||
        eventTime == null) {
      throw Exception(
        "Selecciona fecha y hora del evento.",
      );
    }

    return DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      eventTime!.hour,
      eventTime!.minute,
    );
  }

  /// ============================================
  /// UPLOAD HERO
  /// ============================================

  Future<void> uploadHero() async {
    if (heroImage == null) {
      throw Exception(
        "Selecciona una imagen principal.",
      );
    }

    final resized = await resizeImage(
      heroImage!,
      1000,
    );

    final ref = FirebaseStorage.instance
        .ref()
        .child(
      "birthday/$slug/hero.jpg",
    );

    await ref.putData(resized);

    heroUrl = await ref.getDownloadURL();
  }

  /// ============================================
  /// UPLOAD GALLERY
  /// ============================================

  Future<void> uploadGallery() async {
    galleryUrls.clear();

    if (galleryImages.isEmpty) {
      return;
    }

    /// IMPORTANTE:
    /// Creamos una lista con su índice para
    /// conservar el orden de las imágenes.
    final results = await Future.wait(
      galleryImages
          .asMap()
          .entries
          .map((entry) async {

        final index = entry.key;
        final bytes = entry.value;

        final resized = await resizeImage(
          bytes,
          1000,
        );

        final ref = FirebaseStorage.instance
            .ref()
            .child(
          "birthday/$slug/gallery/$index.jpg",
        );

        await ref.putData(resized);

        return await ref.getDownloadURL();
      }),
    );

    galleryUrls.addAll(results);
  }

  /// ============================================
  /// SLUG
  /// ============================================

  String generateSlug(
      String name,
      String age,
      ) {
    final base = name
        .toLowerCase()
        .trim()
        .replaceAll(
      RegExp(r'[^\w\s-]'),
      '',
    )
        .replaceAll(
      RegExp(r'\s+'),
      '-',
    );

    final unique = DateTime.now()
        .millisecondsSinceEpoch
        .toString()
        .substring(8);

    return "$base-$age-$unique";
  }

  /// ============================================
  /// VALIDACIONES
  /// ============================================

  bool validateForm() {
    if (nameCtrl.text.trim().isEmpty) {
      showMessage(
        "Ingresa el nombre del festejado.",
      );
      return false;
    }

    if (ageCtrl.text.trim().isEmpty) {
      showMessage(
        "Ingresa la edad.",
      );
      return false;
    }

    if (placeCtrl.text.trim().isEmpty) {
      showMessage(
        "Ingresa el lugar del evento.",
      );
      return false;
    }

    if (selectedDate == null) {
      showMessage(
        "Selecciona la fecha.",
      );
      return false;
    }

    if (eventTime == null) {
      showMessage(
        "Selecciona la hora.",
      );
      return false;
    }

    if (heroImage == null) {
      showMessage(
        "Selecciona una imagen principal.",
      );
      return false;
    }

    return true;
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  /// ============================================
  /// CREATE INVITATION
  /// ============================================

  Future<void> createInvitation() async {
    if (!validateForm()) return;

    setState(() {
      loading = true;
    });

    try {
      slug = generateSlug(
        nameCtrl.text,
        ageCtrl.text,
      );

      /// Subimos imágenes
      await Future.wait([
        uploadHero(),
        uploadGallery(),
      ]);

      /// Creamos invitación
      await InvitationService()
          .createInvitationBirthday(
        slug: slug,

        /// AQUÍ ESTÁ EL CAMBIO IMPORTANTE
        template: selectedTemplate,

        /// Spider-Man realmente no necesita theme,
        /// pero mantenemos el campo para no romper
        /// InvitationModel.
        theme: selectedTemplate == "birthday"
            ? selectedTheme
            : selectedTemplate,

        title: nameCtrl.text.trim(),

        heroImage: heroUrl,

        quote: phraseCtrl.text.trim(),

        eventDate: getFinalDateTime(),

        location: placeCtrl.text.trim(),

        mapsUrl: mapsCtrl.text.trim(),

        /// Lo dejamos también porque actualmente
        /// algunos templates utilizan receptionMaps.
        receptionMaps: mapsCtrl.text.trim(),

        gallery: galleryUrls,

        snackBar: {
          "image":
          "assets/snacks/mv_snacks.jpg",

          "title":
          snackTitleCtrl.text.trim(),

          "subtitle":
          snackSubtitleCtrl.text.trim(),

          "startTime":
          snackStartCtrl.text.trim(),

          "endTime":
          snackEndCtrl.text.trim(),

          "items": [
            "Gomitas",
            "Frutas",
            "Verduras",
            "Sabritas",
          ],
        },
      );

      if (!mounted) return;

      context.go(
        "/invitation/$slug",
      );
    } catch (e) {
      if (!mounted) return;

      showMessage(
        "Error: $e",
      );
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  /// ============================================
  /// UI
  /// ============================================

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
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 40,
        ),

        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 700,
            ),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.stretch,
              children: [

                /// =================================
                /// HEADER
                /// =================================

                Text(
                  "Crea tu invitación",
                  textAlign: TextAlign.center,
                  style:
                  GoogleFonts.playfairDisplay(
                    fontSize: 32,
                    color: champagne,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Cumpleaños",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 40),

                /// =================================
                /// TEMPLATE
                /// =================================

                _sectionTitle(
                  "Elige una invitación",
                  champagne,
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    _templateCard(
                      title: "Cumpleaños",
                      value: "birthday",
                      color:
                      const Color(0xFF6B4A2F),
                    ),

                    const SizedBox(width: 12),

                    _templateCard(
                      title: "Spider-Man",
                      value: "spiderman",
                      color:
                      const Color(0xFFE62429),
                    ),

                    const SizedBox(width: 12),

                    _templateCard(
                      title: "Pokemon",
                      value: "pokemon",
                      color:
                      const Color(0xFFE62429),
                    ),

                    const SizedBox(width: 12),

                    _templateCard(
                      title: "Mario Bros",
                      value: "mario_bros",
                      color:
                      const Color(0xFF6D0B0D),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                /// =================================
                /// INFORMACIÓN
                /// =================================

                _sectionTitle(
                  "Información del festejado",
                  champagne,
                ),

                const SizedBox(height: 18),

                _input(
                  "Nombre del festejado",
                  nameCtrl,
                ),

                _input(
                  "Edad",
                  ageCtrl,
                  keyboardType:
                  TextInputType.number,
                ),

                _input(
                  "Frase (opcional)",
                  phraseCtrl,
                ),

                const SizedBox(height: 10),

                /// =================================
                /// EVENTO
                /// =================================

                _sectionTitle(
                  "Información del evento",
                  champagne,
                ),

                const SizedBox(height: 18),

                _input(
                  "Lugar",
                  placeCtrl,
                ),

                _input(
                  "Link de Google Maps",
                  mapsCtrl,
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: pickDate,
                        child: Text(
                          selectedDate == null
                              ? "Seleccionar fecha"
                              : "${selectedDate!.day}/"
                              "${selectedDate!.month}/"
                              "${selectedDate!.year}",
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: pickTime,
                        child: Text(
                          eventTime == null
                              ? "Seleccionar hora"
                              : eventTime!
                              .format(context),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                /// =================================
                /// HERO
                /// =================================

                _sectionTitle(
                  "Imagen principal",
                  champagne,
                ),

                const SizedBox(height: 18),

                ElevatedButton.icon(
                  onPressed: pickHero,
                  icon: const Icon(
                    Icons.image_outlined,
                  ),
                  label: const Text(
                    "Seleccionar imagen principal",
                  ),
                ),

                if (heroImage != null) ...[
                  const SizedBox(height: 15),

                  ClipRRect(
                    borderRadius:
                    BorderRadius.circular(18),
                    child: Image.memory(
                      heroImage!,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],

                /// =================================
                /// THEME BIRTHDAY
                /// =================================

                if (selectedTemplate ==
                    "birthday") ...[
                  const SizedBox(height: 35),

                  _sectionTitle(
                    "Elige un estilo",
                    champagne,
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      _themeCard(
                        "Cowboy",
                        "cowboy",
                        Colors.brown,
                      ),

                      const SizedBox(width: 12),

                      _themeCard(
                        "Neón",
                        "neon",
                        Colors.greenAccent,
                      ),

                      const SizedBox(width: 12),

                      _themeCard(
                        "Elegante",
                        "elegant",
                        Colors.black54,
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 35),

                /// =================================
                /// SNACK BAR
                /// =================================

                _sectionTitle(
                  "Barra de Snacks",
                  champagne,
                ),

                const SizedBox(height: 18),

                _input(
                  "Título",
                  snackTitleCtrl,
                ),

                _input(
                  "Descripción",
                  snackSubtitleCtrl,
                ),

                Row(
                  children: [
                    Expanded(
                      child: _input(
                        "Hora inicio",
                        snackStartCtrl,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _input(
                        "Hora final",
                        snackEndCtrl,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// =================================
                /// GALERÍA
                /// =================================

                _sectionTitle(
                  "Galería",
                  champagne,
                ),

                const SizedBox(height: 18),

                ElevatedButton.icon(
                  onPressed: pickGallery,
                  icon: const Icon(
                    Icons.photo_library_outlined,
                  ),
                  label: const Text(
                    "Seleccionar galería",
                  ),
                ),

                if (galleryImages.isNotEmpty) ...[
                  const SizedBox(height: 15),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children:
                    galleryImages.map((image) {
                      return ClipRRect(
                        borderRadius:
                        BorderRadius.circular(10),
                        child: Image.memory(
                          image,
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                  ),
                ],

                const SizedBox(height: 45),

                /// =================================
                /// CREATE
                /// =================================

                GestureDetector(
                  onTap:
                  loading ? null : createInvitation,
                  child: AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    width: double.infinity,
                    height: 58,
                    decoration: BoxDecoration(
                      color: loading
                          ? champagne.withOpacity(.6)
                          : champagne,
                      borderRadius:
                      BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: loading
                          ? const SizedBox(
                        width: 25,
                        height: 25,
                        child:
                        CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text(
                        "Crear invitación",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ============================================
  /// SECTION TITLE
  /// ============================================

  Widget _sectionTitle(
      String title,
      Color color,
      ) {
    return Text(
      title,
      style: GoogleFonts.playfairDisplay(
        fontSize: 21,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// ============================================
  /// INPUT
  /// ============================================

  Widget _input(
      String label,
      TextEditingController controller, {
        TextInputType? keyboardType,
      }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 18,
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(16),
            borderSide: BorderSide(
              color:
              Colors.black.withOpacity(.08),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFF6B4A2F),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  /// ============================================
  /// TEMPLATE CARD
  /// ============================================

  Widget _templateCard({
    required String title,
    required String value,
    required Color color,
  }) {
    final selected =
        selectedTemplate == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTemplate = value;
          });
        },
        child: AnimatedContainer(
          duration:
          const Duration(milliseconds: 180),
          height: 115,
          decoration: BoxDecoration(
            color: color,
            borderRadius:
            BorderRadius.circular(16),
            border: Border.all(
              color: selected
                  ? Colors.black87
                  : Colors.transparent,
              width: 3,
            ),
            boxShadow: selected
                ? [
              BoxShadow(
                color:
                Colors.black.withOpacity(.15),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ]
                : [],
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight:
                    FontWeight.w700,
                  ),
                ),
              ),

              if (selected)
                const Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// ============================================
  /// THEME CARD
  /// ============================================

  Widget _themeCard(
      String title,
      String value,
      Color color,
      ) {
    final selected =
        selectedTheme == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTheme = value;
          });
        },
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(16),
            border: Border.all(
              color: selected
                  ? const Color(0xFF6B4A2F)
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.circular(14),
                  child: Container(
                    color: color,
                  ),
                ),
              ),

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color:
                    Colors.black.withOpacity(.30),
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                ),
              ),

              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),
              ),

              if (selected)
                const Positioned(
                  top: 8,
                  right: 8,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}