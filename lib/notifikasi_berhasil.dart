import 'package:flutter/material.dart';

class NotifikasiBerhasilPage extends StatefulWidget {
  const NotifikasiBerhasilPage({super.key});

  @override
  State<NotifikasiBerhasilPage> createState() => _NotifikasiBerhasilPageState();
}

class _NotifikasiBerhasilPageState extends State<NotifikasiBerhasilPage>
    with TickerProviderStateMixin {
  late AnimationController _iconController;
  late Animation<double> _iconScaleAnimation;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _iconScaleAnimation =
        CurvedAnimation(parent: _iconController, curve: Curves.elasticOut);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    // Start animations in sequence
    _iconController.forward().then((_) {
      _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _iconController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buat Pengaduan',
          style: TextStyle(color: Colors.red),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _iconScaleAnimation,
              child: const Icon(Icons.check_circle, size: 120, color: Colors.red),
            ),
            const SizedBox(height: 29),
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                'Pengaduan BERHASIL dibuat!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                'assets/img/notifikasi_done.png',
                height: 400,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
