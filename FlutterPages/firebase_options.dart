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
    apiKey: 'AIzaSyDEciF7g6dwjdCW85pkjxpA-wqUJyIYDSI',
    appId: '1:733501743044:web:48cf4a94290530008a4e91',
    messagingSenderId: '733501743044',
    projectId: 'iotapp-17a70',
    authDomain: 'iotapp-17a70.firebaseapp.com',
    storageBucket: 'iotapp-17a70.appspot.com',
    measurementId: 'G-B9Y088CKW0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBCJz852hW41Pi-jkuaK4jCDC4K96Rujss',
    appId: '1:733501743044:android:abff445d0553b0258a4e91',
    messagingSenderId: '733501743044',
    projectId: 'iotapp-17a70',
    storageBucket: 'iotapp-17a70.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC22KjHY5_E8qIDad89wrMyOKg_jYgXL2A',
    appId: '1:733501743044:ios:c3a79808fc84acbb8a4e91',
    messagingSenderId: '733501743044',
    projectId: 'iotapp-17a70',
    storageBucket: 'iotapp-17a70.appspot.com',
    iosBundleId: 'com.example.iotApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC22KjHY5_E8qIDad89wrMyOKg_jYgXL2A',
    appId: '1:733501743044:ios:c3a79808fc84acbb8a4e91',
    messagingSenderId: '733501743044',
    projectId: 'iotapp-17a70',
    storageBucket: 'iotapp-17a70.appspot.com',
    iosBundleId: 'com.example.iotApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDEciF7g6dwjdCW85pkjxpA-wqUJyIYDSI',
    appId: '1:733501743044:web:f71d5dca60fcde718a4e91',
    messagingSenderId: '733501743044',
    projectId: 'iotapp-17a70',
    authDomain: 'iotapp-17a70.firebaseapp.com',
    storageBucket: 'iotapp-17a70.appspot.com',
    measurementId: 'G-TSGR91ZSWH',
  );
}
