import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

class FirebaseInitializer {
  static Future<void>? _initialization;

  static Future<void> initialize() {
    return _initialization ??= Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}