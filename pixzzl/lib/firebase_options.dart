// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDXuJtPFaZUcQ53wqyuMRnDAodN3yKA4Yc',
    appId: '1:16793535651:web:f6e30b64e34637f2012b16',
    messagingSenderId: '16793535651',
    projectId: 'pixzzle-app',
    authDomain: 'pixzzle-app.firebaseapp.com',
    storageBucket: 'pixzzle-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCyPGILJZl_16B37gxco3chgkOvfr_Hibc',
    appId: '1:16793535651:android:ed32433ba2a5f71f012b16',
    messagingSenderId: '16793535651',
    projectId: 'pixzzle-app',
    storageBucket: 'pixzzle-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDzr9W7eKWfDkA-m7Hg8lJbt59YH4LFZ7E',
    appId: '1:16793535651:ios:19bdd4432a8e0e5f012b16',
    messagingSenderId: '16793535651',
    projectId: 'pixzzle-app',
    storageBucket: 'pixzzle-app.appspot.com',
    iosClientId: '16793535651-d806h2vrk77fbmvqkolv7ts5c2fahehl.apps.googleusercontent.com',
    iosBundleId: 'com.example.pixzzl',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDzr9W7eKWfDkA-m7Hg8lJbt59YH4LFZ7E',
    appId: '1:16793535651:ios:8d61967c2e799def012b16',
    messagingSenderId: '16793535651',
    projectId: 'pixzzle-app',
    storageBucket: 'pixzzle-app.appspot.com',
    iosClientId: '16793535651-9d2kgds8eghfh68ln7k1mj0ftk4kp77i.apps.googleusercontent.com',
    iosBundleId: 'com.example.pixzzl.RunnerTests',
  );
}