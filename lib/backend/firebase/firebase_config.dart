import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAgMeoKno_alKmojxNqFqFJcfFjg9diPIQ",
            authDomain: "test-7acd7.firebaseapp.com",
            projectId: "test-7acd7",
            storageBucket: "test-7acd7.appspot.com",
            messagingSenderId: "782996771488",
            appId: "1:782996771488:web:467a40b94fea9191632fc5",
            measurementId: "G-VCDDXJLYD5"));
  } else {
    await Firebase.initializeApp();
  }
}
