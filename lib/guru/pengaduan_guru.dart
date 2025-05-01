import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyek_3/firebase_options.dart'; // File ini dihasilkan oleh Firebase CLI

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PengaduanGuruPage(),
  ));
}

class PengaduanGuruPage extends StatelessWidget {
  const PengaduanGuruPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penanganan Pengaduan'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('pengaduan')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Terjadi kesalahan.'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text('Belum ada pengaduan.'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final pengaduan = docs[index];
              final data = pengaduan.data() as Map<String, dynamic>;

              return ListTile(
                leading: const Icon(Icons.report_problem, color: Colors.red),
                title: Text(data['judul'] ?? 'Tanpa Judul'),
                subtitle: Text(
                  '${data['kategori']} - ${data.containsKey('displayName') ? data['displayName'] : data['userEmail']}',
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPengaduanPage(
                        pengaduanId: pengaduan.id,
                        data: pengaduan,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class DetailPengaduanPage extends StatefulWidget {
  final String pengaduanId;
  final DocumentSnapshot data;

  const DetailPengaduanPage({
    super.key,
    required this.pengaduanId,
    required this.data,
  });

  @override
  State<DetailPengaduanPage> createState() => _DetailPengaduanPageState();
}

class _DetailPengaduanPageState extends State<DetailPengaduanPage> {
  String? _status;
  final _catatanController = TextEditingController();

  Future<void> _updateStatus() async {
    if (_status == null) return;

    await FirebaseFirestore.instance
        .collection('pengaduan')
        .doc(widget.pengaduanId)
        .update({
      'status': _status,
      'catatanGuru': _catatanController.text,
      'ditanganiPada': FieldValue.serverTimestamp(),
    });

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data.data() as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengaduan'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Judul:', style: _labelStyle()),
            Text(data['judul'] ?? '', style: _valueStyle()),
            const SizedBox(height: 12),
            Text('Kategori:', style: _labelStyle()),
            Text(data['kategori'] ?? '', style: _valueStyle()),
            const SizedBox(height: 12),
            Text('Deskripsi:', style: _labelStyle()),
            Text(data['deskripsi'] ?? '', style: _valueStyle()),
            const SizedBox(height: 12),
            Text('Dari:', style: _labelStyle()),
            Text(data.containsKey('displayName') ? data['displayName'] : data['userEmail'], style: _valueStyle()),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _status,
              decoration: const InputDecoration(
                labelText: 'Status Penanganan',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Diproses', child: Text('Diproses')),
                DropdownMenuItem(value: 'Selesai', child: Text('Selesai')),
                DropdownMenuItem(value: 'Ditolak', child: Text('Ditolak')),
              ],
              onChanged: (val) => setState(() => _status = val),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _catatanController,
              decoration: const InputDecoration(
                labelText: 'Catatan Penanganan (Optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateStatus,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Simpan Penanganan'),
            )
          ],
        ),
      ),
    );
  }

  TextStyle _labelStyle() =>
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 14);

  TextStyle _valueStyle() =>
      const TextStyle(fontSize: 15, color: Colors.black87);
}
