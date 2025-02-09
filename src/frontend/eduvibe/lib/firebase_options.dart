import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return const FirebaseOptions(
          apiKey: "AIzaSyCIBwdb0Dkbez-Aj96ncLPi9CQ2LG97Rmg",
          authDomain: "eduvibe-6c746.firebaseapp.com",
          projectId: "eduvibe-6c746",
          storageBucket: "eduvibe-6c746.firebasestorage.app",
          messagingSenderId: "382173754717",
          appId: "1:382173754717:web:a566c9d70c535ead4e24b4",
          measurementId: "G-0LES5GGW6G");
    } else {
      return const FirebaseOptions(
        apiKey: "AIzaSyCIBwdb0Dkbez-Aj96ncLPi9CQ2LG97Rmg",
        projectId: "eduvibe-6c746",
        messagingSenderId: "382173754717",
        appId: "1:382173754717:web:a566c9d70c535ead4e24b4",
      );
    }
  }
}
