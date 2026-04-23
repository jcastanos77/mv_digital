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
  State<BirthdayBuilderPage> createState() => _BirthdayBuilderPageState();
}

class _BirthdayBuilderPageState extends State<BirthdayBuilderPage> {

  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final phraseCtrl = TextEditingController();
  final placeCtrl = TextEditingController();
  final mapsCtrl = TextEditingController();

  String selectedTheme = "cowboy";

  final picker = ImagePicker();

  Uint8List? heroImage;
  List<Uint8List> galleryImages = [];

  String heroUrl = "";
  List<String> galleryUrls = [];

  bool loading = false;
  String slug = "";

  TimeOfDay? eventTime;
  DateTime? selectedDate;

  /// ===============================
  /// PICKERS
  /// ===============================

  Future pickHero() async {
    final file = await picker.pickImage(source: ImageSource.gallery);
    if(file == null) return;

    heroImage = await file.readAsBytes();
    setState(() {});
  }

  Future pickGallery() async {
    final files = await picker.pickMultiImage();
    if(files.isEmpty) return;

    for(final f in files){
      galleryImages.add(await f.readAsBytes());
    }

    setState(() {});
  }

  Future pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if(date != null){
      selectedDate = date;
      setState(() {});
    }
  }

  Future pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if(time != null){
      eventTime = time;
      setState(() {});
    }
  }

  /// ===============================
  /// RESIZE
  /// ===============================

  Future<Uint8List> resizeImage(Uint8List bytes,int width) async {
    final decoded = img.decodeImage(bytes)!;
    final resized = img.copyResize(decoded,width: width);
    final jpg = img.encodeJpg(resized,quality: 80);
    return Uint8List.fromList(jpg);
  }

  DateTime getFinalDateTime() {
    if(selectedDate == null || eventTime == null){
      return DateTime.now();
    }

    return DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      eventTime!.hour,
      eventTime!.minute,
    );
  }

  /// ===============================
  /// UPLOADS
  /// ===============================

  Future uploadHero() async {

    if(heroImage == null) return;

    final resized = await resizeImage(heroImage!, 1200);

    final ref = FirebaseStorage.instance
        .ref()
        .child("birthday/$slug/hero.jpg");

    await ref.putData(resized);
    heroUrl = await ref.getDownloadURL();
  }

  Future uploadGallery() async {

    galleryUrls.clear();

    await Future.wait(
      galleryImages.asMap().entries.map((entry) async {

        final i = entry.key;
        final bytes = entry.value;

        final resized = await resizeImage(bytes, 1200);

        final ref = FirebaseStorage.instance
            .ref()
            .child("birthday/$slug/gallery/$i.jpg");

        await ref.putData(resized);

        final url = await ref.getDownloadURL();
        galleryUrls.add(url);

      }),
    );
  }

  /// ===============================
  /// SLUG
  /// ===============================

  String generateSlug(String name, String age) {
    final base = name
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .replaceAll(' ', '-');

    final unique =
    DateTime.now().millisecondsSinceEpoch.toString().substring(8);

    return "$base-$age-$unique";
  }

  /// ===============================
  /// CREATE
  /// ===============================

  Future createInvitation() async {

    setState(() => loading = true);

    try {

      slug = generateSlug(
        nameCtrl.text,
        ageCtrl.text,
      );

      await Future.wait([
        uploadHero(),
        uploadGallery(),
      ]);

      await InvitationService().createInvitationBirthday(
        slug: slug,
        template: "birthday",
        theme: selectedTheme,
        title: nameCtrl.text,
        heroImage: heroUrl,
        quote: phraseCtrl.text,
        eventDate: getFinalDateTime(),
        location: placeCtrl.text,
        gallery: galleryUrls,
        receptionMaps: mapsCtrl.text,
        mapsUrl: ""
      );

      if(context.mounted){
        context.go("/invitation/$slug");
      }

    } catch(e){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }

    setState(() => loading = false);
  }

  /// ===============================
  /// UI
  /// ===============================

  @override
  Widget build(BuildContext context) {

    const champagne = Color(0xFF6B4A2F);
    const bg = Color(0xFFF5F5F5);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          children: [

            Text(
              "Crea tu invitación",
              style: GoogleFonts.playfairDisplay(
                fontSize: 32,
                color: champagne,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 40),

            _input("Nombre del festejado", nameCtrl),
            _input("Edad", ageCtrl),
            _input("Frase (opcional)", phraseCtrl),
            _input("Lugar", placeCtrl),

            _input("Ubicación (texto)", placeCtrl),
            _input("Link de Google Maps", mapsCtrl),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: ElevatedButton(
                    onPressed: pickDate,
                    child: Text(
                      selectedDate == null
                          ? "Seleccionar fecha"
                          : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
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
                          : eventTime!.format(context),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// HERO
            ElevatedButton(
              onPressed: pickHero,
              child: const Text("Seleccionar imagen principal"),
            ),

            if(heroImage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.memory(heroImage!, height: 180),
              ),

            const SizedBox(height: 30),

            /// TEMA
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Elige un estilo",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  color: champagne,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                _themeCard("Cowboy", "cowboy", Colors.brown),
                const SizedBox(width: 12),
                _themeCard("Neón", "neon", Colors.greenAccent),
                const SizedBox(width: 12),
                _themeCard("Elegante", "elegant", Colors.black54),
              ],
            ),

            const SizedBox(height: 30),

            /// GALERIA
            ElevatedButton(
              onPressed: pickGallery,
              child: const Text("Seleccionar galería"),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              children: galleryImages.map((img){
                return Image.memory(img, width: 80, height: 80, fit: BoxFit.cover);
              }).toList(),
            ),

            const SizedBox(height: 40),

            /// BOTON
            GestureDetector(
              onTap: loading ? null : createInvitation,
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: champagne,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    "Crear invitación",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _input(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _themeCard(String title, String value, Color color) {

    final isSelected = selectedTheme == value;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTheme = value),
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF6B4A2F)
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Stack(
            children: [

              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  color: color,
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.3),
                  borderRadius: BorderRadius.circular(14),
                ),
              ),

              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}