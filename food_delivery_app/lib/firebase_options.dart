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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBI-ZIIoVU57NTfAwqkNfBVNBLKDo-tYSg',
    appId: '1:258310512244:web:3b0b2e314e9c4025dcbb21',
    messagingSenderId: '258310512244',
    projectId: 'food-delivery-app-9649b',
    authDomain: 'food-delivery-app-9649b.firebaseapp.com',
    storageBucket: 'food-delivery-app-9649b.appspot.com',
    measurementId: 'G-S8VXNWPH92',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAAhPqKhz078ezk5GFtwJRpIb5daPI0Esw',
    appId: '1:258310512244:android:ab50f5520126d154dcbb21',
    messagingSenderId: '258310512244',
    projectId: 'food-delivery-app-9649b',
    storageBucket: 'food-delivery-app-9649b.appspot.com',
  );
}