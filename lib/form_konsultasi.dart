import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'konsultasi.dart';

class BuatKonsultasiPage extends StatefulWidget {
  final String kategori;

  const BuatKonsultasiPage({super.key, required this.kategori});

  @override
  State<BuatKonsultasiPage> createState() => _BuatKonsultasiPageState();
}

class _BuatKonsultasiPageState extends State<BuatKonsultasiPage> {
  final TextEditingController judulController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  late String kategoriKonsultasi;
  String? konselorDipilih;

  @override
  void initState() {
    super.initState();
    kategoriKonsultasi = widget.kategori;
  }

  Future<void> _kirimKonsultasi() async {
    final String judul = judulController.text.trim();
    final String deskripsi = deskripsiController.text.trim();
    final String kategori = kategoriKonsultasi;
    final String? konselor = konselorDipilih;

    if (judul.isEmpty || deskripsi.isEmpty || konselor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua data wajib diisi, kecuali lampiran')),
      );
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User belum login');
      }

      await FirebaseFirestore.instance.collection('konsultasi').add({
        'judul': judul,
        'deskripsi': deskripsi,
        'kategori': kategori,
        'konselor': konselor,
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'menunggu',
        'userId': user.uid,
        'userEmail': user.email,
        'displayName': user.displayName ?? '',
      });

      Navigator.pushNamed(context, '/notifikasi-berhasil');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengirim konsultasi: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Konsultasi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const KonsultasiPage()),
            );
          },
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.5,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildSectionTitle("Judul Konsultasi"),
                  TextFormField(
                    controller: judulController,
                    decoration: _inputDecoration("Masukan judul konsultasi"),
                  ),
                  const SizedBox(height: 16),

                  _buildSectionTitle("Kategori Konsultasi"),
                  DropdownButtonFormField<String>(
                    decoration: _inputDecoration(null),
                    value: kategoriKonsultasi,
                    items: ['Pribadi', 'Akademik', 'Karier', 'Sosial']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        kategoriKonsultasi = val!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  _buildSectionTitle("Konselor"),
                  DropdownButtonFormField<String>(
                    decoration: _inputDecoration("Pilih konselor"),
                    value: konselorDipilih,
                    items: ['Konselor A', 'Konselor B']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        konselorDipilih = val;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  _buildSectionTitle("Deskripsi Masalah"),
                  TextFormField(
                    controller: deskripsiController,
                    maxLines: 6,
                    decoration: _inputDecoration("Jelaskan detail masalah..."),
                  ),
                  const SizedBox(height: 16),

                  _buildSectionTitle("Lampiran (Optional)"),
                  InkWell(
                    onTap: () {
                      // logika upload lampiran bisa ditambah nanti
                    },
                    child: Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade100,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.upload_file, size: 40, color: Colors.redAccent),
                          SizedBox(height: 8),
                          Text("Klik untuk mengunggah file"),
                          Text("PNG, JPG, PDF", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _kirimKonsultasi,
                      icon: const Icon(Icons.send),
                      label: const Text("Kirim Konsultasi"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String? hintText) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }
}
