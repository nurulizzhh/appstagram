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
    apiKey: 'AIzaSyADNBPz5oHYPdD6yoPolBj1fqVztc2o-EY',
    appId: '1:506797289918:web:1f75175a58a9f5975fc9ef',
    messagingSenderId: '506797289918',
    projectId: 'appstagram-181ea',
    authDomain: 'appstagram-181ea.firebaseapp.com',
    storageBucket: 'appstagram-181ea.appspot.com',
    measurementId: 'G-3VLEPWGH3R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBCMyilO9mArMsilzNY8SQjtNvqjWdpEo4',
    appId: '1:506797289918:android:315587308f92490d5fc9ef',
    messagingSenderId: '506797289918',
    projectId: 'appstagram-181ea',
    storageBucket: 'appstagram-181ea.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCz2WE6AwTde2bZ3dVNN2qKg4edpJkg8fI',
    appId: '1:506797289918:ios:5b6ae571aea3ce5b5fc9ef',
    messagingSenderId: '506797289918',
    projectId: 'appstagram-181ea',
    storageBucket: 'appstagram-181ea.appspot.com',
    iosBundleId: 'com.example.appstagram',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCz2WE6AwTde2bZ3dVNN2qKg4edpJkg8fI',
    appId: '1:506797289918:ios:d2743ae32f3a82d05fc9ef',
    messagingSenderId: '506797289918',
    projectId: 'appstagram-181ea',
    storageBucket: 'appstagram-181ea.appspot.com',
    iosBundleId: 'com.example.appstagram.RunnerTests',
  );
}