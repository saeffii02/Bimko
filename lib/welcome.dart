import 'dart:async';
import 'package:proyek_3/home.dart'; 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // file ini auto-generated saat kamu setup Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}

// ---------------- WELCOME SCREEN ----------------

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Fade-in animasi
    Future.delayed(const Duration(milliseconds: 700), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // Setelah 5 detik, mulai fade-out lalu navigasi
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _opacity = 0.0;
      });

      // Tunggu fade-out selesai baru pindah halaman
      Future.delayed(const Duration(milliseconds: 700), () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(147, 0, 0, 1),
      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 700),
        opacity: _opacity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/img/icon_owl.png', width: 210),
              const SizedBox(height: 17),
              const Text(
                'BIMKO',
                style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'ProtestGuerrilla',
                ),
              ),
              const SizedBox(height: 200),
              const Text(
                '\u00A9 2024 Powered by BK SMANSA SMAN 1 SINDANG.',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- LOGIN SCREEN ----------------

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _opacity = 0.0;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  Future<void> _signIn() async {
    setState(() => _isLoading = true);
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Jika berhasil login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Berhasil login!")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );

    } on FirebaseAuthException catch (e) {
      String message = 'Terjadi kesalahan';
      if (e.code == 'user-not-found') {
        message = 'Akun tidak ditemukan';
      } else if (e.code == 'wrong-password') {
        message = 'Password salah';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 600),
              opacity: _opacity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Text(
                      'BIMKO',
                      style: TextStyle(
                        fontSize: 39,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(147, 0, 0, 1),
                        fontFamily: 'ProtestGuerrilla',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Image.asset('assets/img/icon_login.png', width: 250),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(right: 90),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "Selamat Datang di ",
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "BIMKO",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(147, 0, 0, 1),
                                fontFamily: 'ProtestGuerrilla',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(right: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Portal Layanan Bimbingan Konseling digital",
                              style: TextStyle(fontSize: 14, color: Colors.black54)),
                          Text("untuk siswa",
                              style: TextStyle(fontSize: 14, color: Colors.black54)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Input Email
                    SizedBox(
                      width: 320,
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person, color: Colors.red),
                          hintText: "Email",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Input Password
                    SizedBox(
                      width: 320,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock, color: Colors.red),
                          suffixIcon: const Icon(Icons.visibility, color: Colors.red),
                          hintText: "Kata Sandi",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Tombol Masuk
                    SizedBox(
                      width: 320,
                      height: 50,
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color.fromARGB(255, 255, 133, 141), Color.fromRGBO(147, 0, 0, 1)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _signIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  "Masuk",
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "© 2024 Powered by ",
                            style: TextStyle(color: Colors.black54, fontSize: 12),
                          ),
                          TextSpan(
                            text: "polindra",
                            style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: " SMAN 1 SINDANG.",
                            style: TextStyle(color: Colors.black54, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
