import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyek_3/akun_guru.dart'; // sesuaikan dengan struktur project kamu
import 'firebase_options.dart'; // jika kamu pakai Firebase CLI untuk setup

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // jika kamu pakai firebase_options.dart
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Akun Guru App',
      debugShowCheckedModeBanner: false,
      home: AkunGuruScreen(username: 'Admin'), // sementara pakai static username
    );
  }
}
