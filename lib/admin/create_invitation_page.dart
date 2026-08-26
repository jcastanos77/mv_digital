import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

import 'package:mv_digital/services/invitation_service.dart';

class CreateInvitationPage extends StatefulWidget {
  const CreateInvitationPage({super.key});

  @override
  State<CreateInvitationPage> createState() =>
      _CreateInvitationPageState();
}

class _CreateInvitationPageState extends State<CreateInvitationPage> {
  final _formKey = GlobalKey<FormState>();

  final title = TextEditingController();
  final quote = TextEditingController();

  final ceremonyPlace = TextEditingController();
  final ceremonyTime = TextEditingController();
  final receptionPlace = TextEditingController();
  final receptionTime = TextEditingController();
  final dressCode = TextEditingController();
  final location = TextEditingController();

  final ceremonyMaps = TextEditingController();
  final receptionMaps = TextEditingController();

  DateTime eventDate = DateTime.now();

  String template = "wedding_glam";
  String theme = "cowboy";

  String generatedSlug = "";

  final picker = ImagePicker();

  Uint8List? heroImage;
  String heroUrl = "";

  Uint8List? ceremonyImageBytes;
  Uint8List? receptionImageBytes;

  String ceremonyImageUrl = "";
  String receptionImageUrl = "";

  final List<Uint8List> galleryImages = [];
  final List<String> galleryUrls = [];

  bool loading = false;

  // ========================================
  // HELPERS
  // ========================================

  bool get isBirthday => template == "birthday";

  bool get isQuinceWithoutImages =>
      template == "quince_sin_imagen";

  bool get requiresImages =>
      !isQuinceWithoutImages;

  String generateSlug(String name) {
    final normalized = name
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'[áàäâ]'), 'a')
        .replaceAll(RegExp(r'[éèëê]'), 'e')
        .replaceAll(RegExp(r'[íìïî]'), 'i')
        .replaceAll(RegExp(r'[óòöô]'), 'o')
        .replaceAll(RegExp(r'[úùüû]'), 'u')
        .replaceAll('ñ', 'n')
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');

    final timestamp =
    DateTime.now().millisecondsSinceEpoch.toString();

    return "$normalized-$timestamp";
  }

  // ========================================
  // PICK IMAGES
  // ========================================

  Future<void> pickHero() async {
    final XFile? file = await picker.pickImage(
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

  Future<void> pickCeremonyImage() async {
    final file = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (file == null) return;

    ceremonyImageBytes = await file.readAsBytes();

    setState(() {});
  }

  Future<void> pickReceptionImage() async {
    final file = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (file == null) return;

    receptionImageBytes = await file.readAsBytes();

    setState(() {});
  }

  // ========================================
  // IMAGE UPLOAD
  // ========================================

  Future<void> uploadCeremonyImage() async {
    if (ceremonyImageBytes == null) return;

    final resized =
    await resizeImage(ceremonyImageBytes!, 1200);

    final ref = FirebaseStorage.instance
        .ref()
        .child("ceremony/$generatedSlug.jpg");

    await ref.putData(resized);

    ceremonyImageUrl = await ref.getDownloadURL();
  }

  Future<void> uploadReceptionImage() async {
    if (receptionImageBytes == null) return;

    final resized =
    await resizeImage(receptionImageBytes!, 1200);

    final ref = FirebaseStorage.instance
        .ref()
        .child("reception/$generatedSlug.jpg");

    await ref.putData(resized);

    receptionImageUrl = await ref.getDownloadURL();
  }

  Future<void> uploadHero() async {
    if (heroImage == null) return;

    final resized = await resizeImage(
      heroImage!,
      1600,
    );

    final ref = FirebaseStorage.instance
        .ref()
        .child("heroes/$generatedSlug.jpg");

    await ref.putData(resized);

    heroUrl = await ref.getDownloadURL();
  }

  Future<void> uploadGallery() async {
    galleryUrls.clear();

    for (int i = 0; i < galleryImages.length; i++) {
      final resized = await resizeImage(
        galleryImages[i],
        1400,
      );

      final ref = FirebaseStorage.instance
          .ref()
          .child("gallery/$generatedSlug/$i.jpg");

      await ref.putData(resized);

      final url = await ref.getDownloadURL();

      galleryUrls.add(url);
    }
  }

  // ========================================
  // CREATE INVITATION
  // ========================================

  Future<void> create() async {
    if (!_formKey.currentState!.validate()) return;

    generatedSlug = generateSlug(title.text);

    setState(() {
      loading = true;
    });

    try {
      if (requiresImages) {
        await Future.wait([
          uploadHero(),
          uploadCeremonyImage(),
          uploadReceptionImage(),
          uploadGallery(),
        ]);
      }

      await InvitationService().createInvitation(
        slug: generatedSlug,
        template: template,
        theme: theme,
        title: title.text.trim(),
        heroImage: requiresImages ? heroUrl : "",
        quote: quote.text.trim(),
        eventDate: eventDate,
        location: location.text.trim(),
        ceremonyPlace: ceremonyPlace.text.trim(),
        ceremonyTime: ceremonyTime.text.trim(),
        ceremonyImage:
        requiresImages ? ceremonyImageUrl : "",
        ceremonyMaps: ceremonyMaps.text.trim(),
        receptionPlace: receptionPlace.text.trim(),
        receptionTime: receptionTime.text.trim(),
        receptionImage:
        requiresImages ? receptionImageUrl : "",
        receptionMaps: receptionMaps.text.trim(),
        dressCode: dressCode.text.trim(),
        gallery: requiresImages ? galleryUrls : [],
      );

      if (context.mounted) {
        context.go("/admin");
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Error al crear la invitación: $e",
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  // ========================================
  // DATE
  // ========================================

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: eventDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      eventDate = picked;

      setState(() {});
    }
  }

  // ========================================
  // RESIZE IMAGE
  // ========================================

  Future<Uint8List> resizeImage(
      Uint8List bytes,
      int width,
      ) async {
    final decoded = img.decodeImage(bytes);

    if (decoded == null) {
      throw Exception("No se pudo procesar la imagen");
    }

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

  // ========================================
  // INPUT
  // ========================================

  Widget input(
      String label,
      TextEditingController controller,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "Campo requerido";
          }

          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE5E5EA),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFB76E79),
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ========================================
  // SECTION
  // ========================================

  Widget section(
      String title,
      List<Widget> children,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5E5EA),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          ...children,
        ],
      ),
    );
  }

  // ========================================
  // DISPOSE
  // ========================================

  @override
  void dispose() {
    title.dispose();
    quote.dispose();

    ceremonyPlace.dispose();
    ceremonyTime.dispose();
    receptionPlace.dispose();
    receptionTime.dispose();
    dressCode.dispose();
    location.dispose();

    ceremonyMaps.dispose();
    receptionMaps.dispose();

    super.dispose();
  }

  // ========================================
  // BUILD
  // ========================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F7),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Crear invitación",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 900,
          ),
          child: Padding(
            padding: const EdgeInsets.all(40),

            child: Form(
              key: _formKey,

              child: ListView(
                children: [

                  // ========================================
                  // INFORMACIÓN BÁSICA
                  // ========================================

                  section(
                    "Información básica",
                    [
                      input(
                        "Título / Nombre",
                        title,
                      ),

                      input(
                        "Frase o mensaje",
                        quote,
                      ),

                      if (requiresImages) ...[
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
                          const SizedBox(height: 20),

                          ClipRRect(
                            borderRadius:
                            BorderRadius.circular(14),
                            child: Image.memory(
                              heroImage!,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ],
                    ],
                  ),

                  // ========================================
                  // EVENTO
                  // ========================================

                  section(
                    "Evento",
                    [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text("Fecha"),
                        subtitle: Text(
                          "${eventDate.day}/${eventDate.month}/${eventDate.year}",
                        ),
                        trailing: const Icon(
                          Icons.calendar_month,
                        ),
                        onTap: pickDate,
                      ),

                      const SizedBox(height: 20),

                      DropdownButtonFormField<String>(
                        value: template,
                        items: const [
                          DropdownMenuItem(
                            value: "wedding_glam",
                            child: Text("Wedding Glam"),
                          ),

                          DropdownMenuItem(
                            value: "quince_glam",
                            child: Text("XV Glam"),
                          ),

                          DropdownMenuItem(
                            value: "quince_sin_imagen",
                            child: Text("XV Princesa 🦋"),
                          ),

                          DropdownMenuItem(
                            value: "birthday",
                            child: Text("Cumpleaños"),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == null) return;

                          setState(() {
                            template = value;

                            // Limpiamos imágenes
                            // si selecciona XV sin imágenes
                            if (isQuinceWithoutImages) {
                              heroImage = null;
                              ceremonyImageBytes = null;
                              receptionImageBytes = null;
                              galleryImages.clear();
                            }
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: "Template",
                        ),
                      ),

                      if (isBirthday) ...[
                        const SizedBox(height: 20),

                        DropdownButtonFormField<String>(
                          value: theme,
                          items: const [
                            DropdownMenuItem(
                              value: "cowboy",
                              child: Text("Cowboy"),
                            ),

                            DropdownMenuItem(
                              value: "pool",
                              child: Text("Albercada"),
                            ),

                            DropdownMenuItem(
                              value: "neon",
                              child: Text("Neón"),
                            ),

                            DropdownMenuItem(
                              value: "elegant",
                              child: Text("Elegante"),
                            ),
                          ],
                          onChanged: (value) {
                            if (value == null) return;

                            setState(() {
                              theme = value;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: "Tema cumpleaños",
                          ),
                        ),
                      ],

                      const SizedBox(height: 20),

                      input(
                        "Ubicación general",
                        location,
                      ),
                    ],
                  ),

                  // ========================================
                  // CEREMONIA
                  // ========================================

                  if (!isBirthday)
                    section(
                      "Ceremonia",
                      [
                        input(
                          "Lugar ceremonia",
                          ceremonyPlace,
                        ),

                        input(
                          "Hora ceremonia",
                          ceremonyTime,
                        ),

                        if (requiresImages) ...[
                          ElevatedButton.icon(
                            onPressed: pickCeremonyImage,
                            icon: const Icon(
                              Icons.add_photo_alternate_outlined,
                            ),
                            label: const Text(
                              "Imagen ceremonia",
                            ),
                          ),

                          if (ceremonyImageBytes != null) ...[
                            const SizedBox(height: 15),

                            ClipRRect(
                              borderRadius:
                              BorderRadius.circular(14),
                              child: Image.memory(
                                ceremonyImageBytes!,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],

                          const SizedBox(height: 20),
                        ],

                        input(
                          "Google Maps ceremonia",
                          ceremonyMaps,
                        ),
                      ],
                    ),

                  // ========================================
                  // RECEPCIÓN
                  // ========================================

                  section(
                    "Recepción",
                    [
                      input(
                        "Lugar recepción",
                        receptionPlace,
                      ),

                      input(
                        "Hora recepción",
                        receptionTime,
                      ),

                      if (requiresImages) ...[
                        ElevatedButton.icon(
                          onPressed: pickReceptionImage,
                          icon: const Icon(
                            Icons.add_photo_alternate_outlined,
                          ),
                          label: const Text(
                            "Imagen recepción",
                          ),
                        ),

                        if (receptionImageBytes != null) ...[
                          const SizedBox(height: 15),

                          ClipRRect(
                            borderRadius:
                            BorderRadius.circular(14),
                            child: Image.memory(
                              receptionImageBytes!,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],

                        const SizedBox(height: 20),
                      ],

                      input(
                        "Google Maps recepción",
                        receptionMaps,
                      ),
                    ],
                  ),

                  // ========================================
                  // DRESS CODE
                  // ========================================

                  if (!isBirthday)
                    section(
                      "Código de vestimenta",
                      [
                        input(
                          "Código de vestimenta",
                          dressCode,
                        ),
                      ],
                    ),

                  // ========================================
                  // GALERÍA
                  // ========================================

                  if (requiresImages)
                    section(
                      "Galería",
                      [
                        ElevatedButton.icon(
                          onPressed: pickGallery,
                          icon: const Icon(
                            Icons.photo_library_outlined,
                          ),
                          label: const Text(
                            "Seleccionar fotos",
                          ),
                        ),

                        if (galleryImages.isNotEmpty) ...[
                          const SizedBox(height: 20),

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
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    ),

                  const SizedBox(height: 20),

                  SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: loading ? null : create,

                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        const Color(0xFFB76E79),
                        foregroundColor: Colors.white,
                      ),

                      child: loading
                          ? const SizedBox(
                        width: 24,
                        height: 24,
                        child:
                        CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text(
                        "Crear invitación",
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}