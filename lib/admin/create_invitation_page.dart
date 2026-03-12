import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mv_digital/services/invitation_service.dart';

class CreateInvitationPage extends StatefulWidget {
  const CreateInvitationPage({super.key});

  @override
  State<CreateInvitationPage> createState() => _CreateInvitationPageState();
}

class _CreateInvitationPageState extends State<CreateInvitationPage> {

  final _formKey = GlobalKey<FormState>();

  final slug = TextEditingController();
  final title = TextEditingController();
  final quote = TextEditingController();

  final ceremonyPlace = TextEditingController();
  final ceremonyTime = TextEditingController();
  final receptionPlace = TextEditingController();
  final receptionTime = TextEditingController();
  final dressCode = TextEditingController();
  final location = TextEditingController();

  final ceremonyImage = TextEditingController();
  final ceremonyMaps = TextEditingController();

  final receptionImage = TextEditingController();
  final receptionMaps = TextEditingController();

  DateTime eventDate = DateTime.now();
  String template = "wedding_glam";

  final picker = ImagePicker();

  Uint8List? heroImage;
  String heroUrl = "";
  Uint8List? ceremonyImageBytes;
  Uint8List? receptionImageBytes;

  String ceremonyImageUrl = "";
  String receptionImageUrl = "";

  List<Uint8List> galleryImages = [];
  List<String> galleryUrls = [];

  bool loading = false;

  /// HERO IMAGE
  Future pickHero() async {
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if(file == null) return;

    final bytes = await file.readAsBytes();

    setState(() {
      heroImage = bytes;
    });
  }

  /// GALLERY
  Future pickGallery() async {

    final files = await picker.pickMultiImage();

    if(files.isEmpty) return;

    for(final f in files){
      final bytes = await f.readAsBytes();
      galleryImages.add(bytes);
    }

    setState(() {});
  }

  Future pickCeremonyImage() async {

    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if(file == null) return;

    final bytes = await file.readAsBytes();

    setState(() {
      ceremonyImageBytes = bytes;
    });

  }

  Future pickReceptionImage() async {

    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if(file == null) return;

    final bytes = await file.readAsBytes();

    setState(() {
      receptionImageBytes = bytes;
    });

  }

  Future uploadCeremonyImage() async {

    if(ceremonyImageBytes == null) return;

    final ref = FirebaseStorage.instance
        .ref()
        .child("ceremony/${slug.text}.jpg");

    await ref.putData(
      ceremonyImageBytes!,
      SettableMetadata(contentType: "image/jpeg"),
    );

    ceremonyImageUrl = await ref.getDownloadURL();

  }

  Future uploadReceptionImage() async {

    if(receptionImageBytes == null) return;

    final ref = FirebaseStorage.instance
        .ref()
        .child("reception/${slug.text}.jpg");

    await ref.putData(
      receptionImageBytes!,
      SettableMetadata(contentType: "image/jpeg"),
    );

    receptionImageUrl = await ref.getDownloadURL();

  }

  /// UPLOAD HERO
  Future uploadHero() async {

    if(heroImage == null) return;

    final ref = FirebaseStorage.instance
        .ref()
        .child("heroes/${slug.text}.jpg");

    await ref.putData(
      heroImage!,
      SettableMetadata(contentType: "image/jpeg"),
    );

    heroUrl = await ref.getDownloadURL();
  }

  /// UPLOAD GALLERY
  Future uploadGallery() async {

    galleryUrls.clear();

    for (int i = 0; i < galleryImages.length; i++) {

      final ref = FirebaseStorage.instance
          .ref()
          .child("gallery/${slug.text}/$i.jpg");

      await ref.putData(
        galleryImages[i],
        SettableMetadata(contentType: "image/jpeg"),
      );

      final url = await ref.getDownloadURL();

      galleryUrls.add(url);
    }
  }

  /// CREATE
  Future create() async {

    if(!_formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
    });

    try {

      await uploadHero();
      await uploadCeremonyImage();
      await uploadReceptionImage();
      await uploadGallery();

      await InvitationService().createInvitation(

        slug: slug.text.trim(),
        template: template,

        title: title.text,
        heroImage: heroUrl,
        quote: quote.text,

        eventDate: eventDate,

        location: location.text,

        ceremonyPlace: ceremonyPlace.text,
        ceremonyTime: ceremonyTime.text,
        ceremonyImage: ceremonyImageUrl,
        ceremonyMaps: ceremonyMaps.text,

        receptionPlace: receptionPlace.text,
        receptionTime: receptionTime.text,
        receptionImage: receptionImageUrl,
        receptionMaps: receptionMaps.text,

        dressCode: dressCode.text,

        gallery: galleryUrls,
      );

      if(context.mounted){
        context.pop();
      }

    } catch(e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );

    }

    setState(() {
      loading = false;
    });
  }

  Future pickDate() async {

    final picked = await showDatePicker(
      context: context,
      initialDate: eventDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if(picked != null){
      setState(() {
        eventDate = picked;
      });
    }
  }

  Widget input(String label, TextEditingController controller){

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        validator: (v) => v!.isEmpty ? "Campo requerido" : null,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget section(String title, List<Widget> children){

    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.05),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          ...children

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF6F6F6),

      appBar: AppBar(
        elevation: 0,
        title: const Text("Crear invitación"),
      ),

      body: Center(
        child: ConstrainedBox(

          constraints: const BoxConstraints(maxWidth: 900),

          child: Padding(
            padding: const EdgeInsets.all(40),

            child: Form(

              key: _formKey,

              child: ListView(

                children: [

                  /// BASICO
                  section("Información básica", [

                    input("Slug (luis-ana)", slug),

                    input("Título", title),

                    input("Quote", quote),

                    const SizedBox(height: 10),

                    ElevatedButton(
                      onPressed: pickHero,
                      child: const Text("Seleccionar Hero"),
                    ),

                    if(heroImage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.memory(
                            heroImage!,
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                  ]),

                  /// EVENTO
                  section("Evento", [

                    ListTile(
                      title: const Text("Fecha"),
                      subtitle: Text(eventDate.toString()),
                      trailing: const Icon(Icons.calendar_month),
                      onTap: pickDate,
                    ),

                    const SizedBox(height: 20),

                    DropdownButtonFormField(

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

                      ],

                      onChanged: (v){
                        setState(() {
                          template = v!;
                        });
                      },

                      decoration: const InputDecoration(
                        labelText: "Template",
                        border: OutlineInputBorder(),
                      ),

                    ),

                    const SizedBox(height: 20),

                    input("Ubicación general", location),

                  ]),

                  /// CEREMONIA
                  section("Ceremonia", [

                    input("Lugar ceremonia", ceremonyPlace),
                    input("Hora ceremonia", ceremonyTime),
                    ElevatedButton(
                      onPressed: pickCeremonyImage,
                      child: const Text("Seleccionar imagen ceremonia"),
                    ),

                    if(ceremonyImageBytes != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.memory(
                            ceremonyImageBytes!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                    const SizedBox(height: 20),

                    input("Google Maps ceremonia", ceremonyMaps),

                  ]),

                  /// RECEPCION
                  section("Recepción", [

                    input("Lugar recepción", receptionPlace),
                    input("Hora recepción", receptionTime),
                    ElevatedButton(
                      onPressed: pickReceptionImage,
                      child: const Text("Seleccionar imagen recepción"),
                    ),

                    if(receptionImageBytes != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.memory(
                            receptionImageBytes!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    input("Google Maps recepción", receptionMaps),

                  ]),

                  /// DRESS CODE
                  section("Dress Code", [

                    input("Código de vestimenta", dressCode),

                  ]),

                  /// GALERIA
                  section("Galería", [

                    ElevatedButton(
                      onPressed: pickGallery,
                      child: const Text("Seleccionar fotos"),
                    ),

                    const SizedBox(height: 20),

                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: galleryImages.map((img){

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.memory(
                            img,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        );

                      }).toList(),
                    ),

                  ]),

                  const SizedBox(height: 20),

                  SizedBox(
                    height: 60,
                    child: ElevatedButton(

                      onPressed: loading ? null : create,

                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),

                      child: loading
                          ? const CircularProgressIndicator()
                          : const Text(
                        "Crear invitación",
                        style: TextStyle(fontSize: 18),
                      ),

                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}