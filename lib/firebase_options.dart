import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyDb-X5KPjOsX3nKsTSrz9J38AotHdEP-wo",
    authDomain: "kasirjeruk.firebaseapp.com",
    projectId: "kasirjeruk",
    storageBucket: "kasirjeruk.appspot.com",
    messagingSenderId: "463379338710",
    appId: "1:463379338710:web:46811d4af4489730eec077",
    measurementId: "G-YJF11383CB",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBEWmvaaVLEL0WZzDV63Dr6iznrc8MGQ7U',
    appId: '1:463379338710:android:071579dfc3045f4eeec077',
    messagingSenderId: '463379338710',
    projectId: 'kasirjeruk',
    storageBucket: 'kasirjeruk.appspot.com',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBEWmvaaVLEL0WZzDV63Dr6iznrc8MGQ7U',
    appId: '1:463379338710:android:071579dfc3045f4eeec077',
    messagingSenderId: '463379338710',
    projectId: 'kasirjeruk',
    storageBucket: 'kasirjeruk.appspot.com',
    iosBundleId: 'com.example.kasirJerukAyang',
  );
}
