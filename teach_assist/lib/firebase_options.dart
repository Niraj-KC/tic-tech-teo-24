// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC2NgQg3wxheBEitNBt4xYvThc3eS4thhY',
    appId: '1:498534609041:web:42c0c23c4f16b75e17cf30',
    messagingSenderId: '498534609041',
    projectId: 'tic-tech-toe-2024',
    authDomain: 'tic-tech-toe-2024.firebaseapp.com',
    storageBucket: 'tic-tech-toe-2024.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBZTEeclrwbwm8GPR3Ez22zvPIj1_qNW_0',
    appId: '1:498534609041:android:67d24ead0946771d17cf30',
    messagingSenderId: '498534609041',
    projectId: 'tic-tech-toe-2024',
    storageBucket: 'tic-tech-toe-2024.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB3kOamYrKIYMm-lfzEfjBUt6VW1eDZ1vk',
    appId: '1:498534609041:ios:484b64f98c18e2f317cf30',
    messagingSenderId: '498534609041',
    projectId: 'tic-tech-toe-2024',
    storageBucket: 'tic-tech-toe-2024.appspot.com',
    iosBundleId: 'com.example.teachAssist',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB3kOamYrKIYMm-lfzEfjBUt6VW1eDZ1vk',
    appId: '1:498534609041:ios:484b64f98c18e2f317cf30',
    messagingSenderId: '498534609041',
    projectId: 'tic-tech-toe-2024',
    storageBucket: 'tic-tech-toe-2024.appspot.com',
    iosBundleId: 'com.example.teachAssist',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC2NgQg3wxheBEitNBt4xYvThc3eS4thhY',
    appId: '1:498534609041:web:c2d934cbff21b2a317cf30',
    messagingSenderId: '498534609041',
    projectId: 'tic-tech-toe-2024',
    authDomain: 'tic-tech-toe-2024.firebaseapp.com',
    storageBucket: 'tic-tech-toe-2024.appspot.com',
  );
}
