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
    apiKey: 'AIzaSyAoO3y8GpA4eQNRi7tNxI-qGGmS-ebRF7Q',
    appId: '1:1004594200020:web:9a0491c97f4bffd5616a41',
    messagingSenderId: '1004594200020',
    projectId: 'xcar-a83b1',
    authDomain: 'xcar-a83b1.firebaseapp.com',
    storageBucket: 'xcar-a83b1.appspot.com',
    measurementId: 'G-Z5Z172XVJP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBZYTOYWydCY-CBF0lGMQzN5v-QWPm-MVc',
    appId: '1:1004594200020:android:85f0af6703577767616a41',
    messagingSenderId: '1004594200020',
    projectId: 'xcar-a83b1',
    storageBucket: 'xcar-a83b1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBw34iHaN8dxmDhymxpJecyRAq7gBjtFcU',
    appId: '1:1004594200020:ios:4fe8d7f15e49af71616a41',
    messagingSenderId: '1004594200020',
    projectId: 'xcar-a83b1',
    storageBucket: 'xcar-a83b1.appspot.com',
    iosBundleId: 'com.carx.carx',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBw34iHaN8dxmDhymxpJecyRAq7gBjtFcU',
    appId: '1:1004594200020:ios:1e9148583beba493616a41',
    messagingSenderId: '1004594200020',
    projectId: 'xcar-a83b1',
    storageBucket: 'xcar-a83b1.appspot.com',
    iosBundleId: 'com.carx.carx.RunnerTests',
  );
}
