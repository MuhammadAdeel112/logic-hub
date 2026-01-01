import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (Platform.isAndroid) {
      return android;
    } else if (Platform.isIOS) {
      return ios;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCyZ0N5VHiYCvuzBiDivDtXCmbjQgwqkUM',
    appId: '1:652810646136:android:30fad56e165d842d32338d',
    messagingSenderId: '652810646136',
    projectId: 'devine-19836',
    storageBucket: 'devine-19836.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC8fKBjWkKbLqESL2lAp_aF8RO65X1D5tU',
    appId: '1:652810646136:ios:f04a08724c3b7e6f32338d',
    messagingSenderId: '652810646136',
    projectId: 'devine-19836',
    storageBucket: 'devine-19836.firebasestorage.app',
    iosBundleId: 'com.spidertechnology.divinecare',
  );
}


// class DefaultFirebaseOptions {
//   static FirebaseOptions get android => const FirebaseOptions(
//     apiKey: "AIzaSyCyZ0N5VHiYCvuzBiDivDtXCmbjQgwqkUM",
//     appId: "1:652810646136:android:30fad56e165d842d32338d",
//     messagingSenderId: "652810646136",
//     projectId: "devine-19836",
//     storageBucket: "devine-19836.firebasestorage.app",
//   );
// }
