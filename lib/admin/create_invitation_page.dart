import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mv_digital/services/invitation_service.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:mv_digital/services/storage_service.dart';

class CreateInvitationPage extends StatefulWidget {
  const CreateInvitationPage({super.key});

  @override
  State<CreateInvitationPage> createState() => _CreateInvitationPageState();
}

class _CreateInvitationPageState extends State<CreateInvitationPage> {

  final _formKey = GlobalKey<FormState>();

  final slug = TextEditingController();
  final title = TextEditingController();
  final hero = TextEditingController();
  final quote = TextEditingController();

  final ceremonyPlace = TextEditingController();
  final ceremonyTime = TextEditingController();
  final receptionPlace = TextEditingController();
  final receptionTime = TextEditingController();

  final dressCode = TextEditingController();

  DateTime eventDate = DateTime.now();
  String template = "wedding_glam";
  Uint8List? heroImage;
  String heroUrl = "";

  final picker = ImagePicker();

  bool loading = false;

  Future create() async {

    if(!_formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
    });

    await uploadHero();

    await InvitationService().createInvitation(
      slug: slug.text,
      template: template,
      title: title.text,
      heroImage: heroUrl,
      eventDate: eventDate,
      ceremonyPlace: ceremonyPlace.text,
      receptionPlace: receptionPlace.text,
      dressCode: dressCode.text,
    );

    if(context.mounted){
      context.pop();
    }

  }

  Future pickHero() async {

    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if(file == null) return;

    final bytes = await file.readAsBytes();

    setState(() {
      heroImage = bytes;
    });

  }

  Future uploadHero() async {

    if(heroImage == null) return;

    final ref = FirebaseStorage.instance
        .ref()
        .child("heroes/${slug.text}.jpg");

    await ref.putData(heroImage!);

    heroUrl = await ref.getDownloadURL();
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
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        validator: (v) => v!.isEmpty ? "Campo requerido" : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Crear Invitación"),
      ),

      body: Center(
        child: ConstrainedBox(

          constraints: const BoxConstraints(maxWidth: 700),

          child: Padding(
            padding: const EdgeInsets.all(30),

            child: Form(

              key: _formKey,

              child: ListView(

                children: [

                  const Text(
                    "Información básica",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  input("Slug (luis-ana)", slug),

                  input("Título", title),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text("Hero Image"),

                      const SizedBox(height: 10),

                      ElevatedButton(
                        onPressed: pickHero,
                        child: const Text("Seleccionar imagen"),
                      ),

                      const SizedBox(height: 20),

                      if(heroImage != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            heroImage!,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),

                    ],
                  ),

                  input("Frase / Quote", quote),

                  const SizedBox(height: 30),

                  const Text(
                    "Evento",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  ListTile(
                    title: const Text("Fecha del evento"),
                    subtitle: Text(eventDate.toString()),
                    trailing: IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: pickDate,
                    ),
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

                  const SizedBox(height: 40),

                  const Text(
                    "Ceremonia",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  input("Lugar ceremonia", ceremonyPlace),

                  input("Hora ceremonia", ceremonyTime),

                  const SizedBox(height: 30),

                  const Text(
                    "Recepción",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  input("Lugar recepción", receptionPlace),

                  input("Hora recepción", receptionTime),

                  const SizedBox(height: 30),

                  const Text(
                    "Dress Code",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  input("Código de vestimenta", dressCode),

                  const SizedBox(height: 40),

                  ElevatedButton(

                    onPressed: loading ? null : create,

                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),

                    child: loading
                        ? const CircularProgressIndicator()
                        : const Text("Crear Invitación"),

                  ),

                ],

              ),

            ),

          ),

        ),
      ),

    );

  }
}