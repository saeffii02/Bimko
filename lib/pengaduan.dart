import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyek_3/notifikasi_berhasil.dart';

class BuatPengaduanPage extends StatefulWidget {
  const BuatPengaduanPage({super.key});

  @override
  State<BuatPengaduanPage> createState() => _BuatPengaduanPageState();
}

class _BuatPengaduanPageState extends State<BuatPengaduanPage> {
  final _judulController = TextEditingController();
  final _deskripsiController = TextEditingController();
  String? _kategori;

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _kirimPengaduan() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User belum login');
      }

      await FirebaseFirestore.instance.collection('pengaduan').add({
        'judul': _judulController.text,
        'kategori': _kategori,
        'deskripsi': _deskripsiController.text,
        'timestamp': FieldValue.serverTimestamp(),
        'userId': user.uid,
        'userEmail': user.email,
        'displayName': user.displayName ?? user.email ?? 'Anonim',
      });


      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const NotifikasiBerhasilPage()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengirim pengaduan: $e')),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Buat Pengaduan',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel('Judul Pengaduan'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _judulController,
                decoration: _inputDecoration('Masukkan judul pengaduan'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Judul wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              _buildLabel('Kategori Pengaduan'),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: _inputDecoration('Pilih kategori'),
                value: _kategori,
                items: const [
                  DropdownMenuItem(value: 'Akademik', child: Text('Akademik')),
                  DropdownMenuItem(value: 'Teknis', child: Text('Teknis')),
                  DropdownMenuItem(value: 'Lainnya', child: Text('Lainnya')),
                ],
                onChanged: (val) => setState(() => _kategori = val),
                validator: (val) =>
                    val == null ? 'Kategori wajib dipilih' : null,
              ),
              const SizedBox(height: 16),
              _buildLabel('Deskripsi Keluhan/Masalah'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _deskripsiController,
                maxLines: 5,
                decoration: _inputDecoration(
                  'Jelaskan detail masalah yang anda hadapi...',
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Deskripsi wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              _buildLabel('Lampiran (Optional)'),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // Logika upload bisa ditambahkan di sini
                },
                child: Container(
                  width: double.infinity,
                  height: 150,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red.shade200),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade50,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(8),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.cloud_upload_outlined,
                          size: 40, color: Colors.grey),
                      SizedBox(height: 12),
                      Text('Klik untuk mengunggah file',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text('PNG, JPG, PDF',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _kirimPengaduan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Kirim Pengaduan',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: Colors.black87,
      ),
    );
  }
}
