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
    apiKey: 'AIzaSyDXVnm3A45Bk3TdTYkz8RKXfkjwuzbDZQE',
    appId: '1:830329376090:web:93b76265dad8593b1ab763',
    messagingSenderId: '830329376090',
    projectId: 'locationtracking-33ef2',
    authDomain: 'locationtracking-33ef2.firebaseapp.com',
    storageBucket: 'locationtracking-33ef2.firebasestorage.app',
    measurementId: 'G-S5B78YY4BP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAB6h64QwDcHRk_xCNvewRqEYbXYQXjiEg',
    appId: '1:830329376090:android:3e91aefb9fddb6991ab763',
    messagingSenderId: '830329376090',
    projectId: 'locationtracking-33ef2',
    storageBucket: 'locationtracking-33ef2.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAfIQPAkJhjAVHhuMJggdCkGVzcEDy1n_A',
    appId: '1:830329376090:ios:8435f8255ba8c7e71ab763',
    messagingSenderId: '830329376090',
    projectId: 'locationtracking-33ef2',
    storageBucket: 'locationtracking-33ef2.firebasestorage.app',
    iosBundleId: 'com.example.shareLocation',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAfIQPAkJhjAVHhuMJggdCkGVzcEDy1n_A',
    appId: '1:830329376090:ios:8435f8255ba8c7e71ab763',
    messagingSenderId: '830329376090',
    projectId: 'locationtracking-33ef2',
    storageBucket: 'locationtracking-33ef2.firebasestorage.app',
    iosBundleId: 'com.example.shareLocation',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDXVnm3A45Bk3TdTYkz8RKXfkjwuzbDZQE',
    appId: '1:830329376090:web:cf4b995d64a78f891ab763',
    messagingSenderId: '830329376090',
    projectId: 'locationtracking-33ef2',
    authDomain: 'locationtracking-33ef2.firebaseapp.com',
    storageBucket: 'locationtracking-33ef2.firebasestorage.app',
    measurementId: 'G-47LW72YKPM',
  );
}
