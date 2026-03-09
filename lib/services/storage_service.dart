import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {

  final storage = FirebaseStorage.instance;

  Future<String> uploadImage({
    required Uint8List file,
    required String path,
  }) async {

    final ref = storage.ref().child(path);

    await ref.putData(file);

    return await ref.getDownloadURL();
  }

}