import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image/image.dart' as img;
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

  final ceremonyMaps = TextEditingController();
  final receptionMaps = TextEditingController();

  DateTime eventDate = DateTime.now();

  String template = "wedding_glam";
  String theme = "cowboy";

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

  /// HERO
  Future pickHero() async {
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if(file == null) return;
    heroImage = await file.readAsBytes();
    setState(() {});
  }

  /// GALLERY
  Future pickGallery() async {

    final files = await picker.pickMultiImage();
    if(files.isEmpty) return;

    for(final f in files){
      galleryImages.add(await f.readAsBytes());
    }

    setState(() {});
  }

  Future pickCeremonyImage() async {
    final file = await picker.pickImage(source: ImageSource.gallery);
    if(file == null) return;
    ceremonyImageBytes = await file.readAsBytes();
    setState(() {});
  }

  Future pickReceptionImage() async {
    final file = await picker.pickImage(source: ImageSource.gallery);
    if(file == null) return;
    receptionImageBytes = await file.readAsBytes();
    setState(() {});
  }

  Future uploadCeremonyImage() async {

    if(ceremonyImageBytes == null) return;

    final ref = FirebaseStorage.instance
        .ref()
        .child("ceremony/${slug.text}.jpg");

    await ref.putData(ceremonyImageBytes!);
    ceremonyImageUrl = await ref.getDownloadURL();
  }

  Future uploadReceptionImage() async {

    if(receptionImageBytes == null) return;

    final ref = FirebaseStorage.instance
        .ref()
        .child("reception/${slug.text}.jpg");

    await ref.putData(receptionImageBytes!);
    receptionImageUrl = await ref.getDownloadURL();
  }

  Future uploadHero() async {

    if(heroImage == null) return;

    final resized = await resizeImage(heroImage!,1600);

    final ref = FirebaseStorage.instance
        .ref()
        .child("heroes/${slug.text}.jpg");

    await ref.putData(resized);
    heroUrl = await ref.getDownloadURL();
  }

  Future uploadGallery() async {

    galleryUrls.clear();

    for(int i=0;i<galleryImages.length;i++){

      final resized = await resizeImage(galleryImages[i],1400);

      final ref = FirebaseStorage.instance
          .ref()
          .child("gallery/${slug.text}/$i.jpg");

      await ref.putData(resized);

      final url = await ref.getDownloadURL();
      galleryUrls.add(url);
    }
  }

  Future create() async {

    if(!_formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
    });

    try{

      await uploadHero();
      await uploadCeremonyImage();
      await uploadReceptionImage();
      await uploadGallery();

      await InvitationService().createInvitation(
        slug: slug.text.trim(),
        template: template,
        theme: theme,
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
        context.go("/admin");
      }

    }catch(e){

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
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
      eventDate = picked;
      setState(() {});
    }
  }

  Future<Uint8List> resizeImage(Uint8List bytes,int width) async {

    final decoded = img.decodeImage(bytes)!;

    final resized = img.copyResize(decoded,width: width);

    final jpg = img.encodeJpg(resized,quality: 80);

    return Uint8List.fromList(jpg);
  }

  Widget input(String label, TextEditingController controller) {

    return Padding(
      padding: const EdgeInsets.only(bottom:20),
      child: TextFormField(
        controller: controller,
        validator: (v)=>v!.isEmpty?"Campo requerido":null,
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget section(String title,List<Widget> children){

    return Container(
      margin: const EdgeInsets.only(bottom:40),
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
            offset: const Offset(0,4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(title,
              style: const TextStyle(
                fontSize:20,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              )),

          const SizedBox(height:20),

          ...children
        ],
      ),
    );
  }

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

          constraints: const BoxConstraints(maxWidth:900),

          child: Padding(
            padding: const EdgeInsets.all(40),

            child: Form(

              key: _formKey,

              child: ListView(

                children: [

                  /// BASICO
                  section("Información básica",[

                    input("Slug",slug),

                    input("Título",title),

                    input("Quote",quote),

                    ElevatedButton(
                      onPressed: pickHero,
                      child: const Text("Seleccionar Hero"),
                    ),

                    if(heroImage!=null)
                      Image.memory(heroImage!,height:200,fit:BoxFit.cover),

                  ]),

                  /// EVENTO
                  section("Evento",[

                    ListTile(
                      title: const Text("Fecha"),
                      subtitle: Text(eventDate.toString()),
                      trailing: const Icon(Icons.calendar_month),
                      onTap: pickDate,
                    ),

                    const SizedBox(height:20),

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

                        DropdownMenuItem(
                          value: "birthday",
                          child: Text("Cumpleaños"),
                        ),

                      ],

                      onChanged: (v){
                        template = v!;
                        setState(() {});
                      },

                      decoration: const InputDecoration(
                        labelText: "Template",
                      ),
                    ),

                    if(template=="birthday")...[
                      const SizedBox(height:20),

                      DropdownButtonFormField(

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

                        onChanged: (v){
                          theme=v!;
                          setState(() {});
                        },

                        decoration: const InputDecoration(
                          labelText: "Tema cumpleaños",
                        ),
                      )
                    ],

                    const SizedBox(height:20),

                    input("Ubicación general",location),

                  ]),

                  if(template!="birthday")
                    section("Ceremonia",[

                      input("Lugar ceremonia",ceremonyPlace),
                      input("Hora ceremonia",ceremonyTime),

                      ElevatedButton(
                        onPressed: pickCeremonyImage,
                        child: const Text("Imagen ceremonia"),
                      ),

                      if(ceremonyImageBytes!=null)
                        Image.memory(ceremonyImageBytes!,height:200),

                      input("Google Maps ceremonia",ceremonyMaps),

                    ]),

                  /// RECEPCION
                  section("Recepción",[

                    input("Lugar recepción",receptionPlace),
                    input("Hora recepción",receptionTime),

                    ElevatedButton(
                      onPressed: pickReceptionImage,
                      child: const Text("Imagen recepción"),
                    ),

                    if(receptionImageBytes!=null)
                      Image.memory(receptionImageBytes!,height:200),

                    input("Google Maps recepción",receptionMaps),

                  ]),

                  /// DRESS CODE
                  section("Dress Code",[

                    input("Código de vestimenta",dressCode),

                  ]),

                  /// GALERIA
                  section("Galería",[

                    ElevatedButton(
                      onPressed: pickGallery,
                      child: const Text("Seleccionar fotos"),
                    ),

                    const SizedBox(height:20),

                    Wrap(
                      spacing:10,
                      runSpacing:10,
                      children: galleryImages.map((img){

                        return Image.memory(
                          img,
                          width:120,
                          height:120,
                          fit: BoxFit.cover,
                        );

                      }).toList(),
                    )

                  ]),

                  const SizedBox(height:20),

                  SizedBox(
                    height:60,
                    child: ElevatedButton(
                      onPressed: loading?null:create,
                      child: loading
                          ? const CircularProgressIndicator()
                          : const Text("Crear invitación"),
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