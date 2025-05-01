import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyek_3/superadmin/superadmin_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // tanpa firebase_options.dart
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Akun Siswa App',
      debugShowCheckedModeBanner: false,
      home: SuperadminDashboard(username: 'Admin'),
    );
  }
}
