import 'package:flutter/material.dart';
import 'package:proyek_3/home.dart';
import 'package:proyek_3/konsultasi.dart';
import 'package:proyek_3/roomchat.dart';
import 'package:proyek_3/welcome.dart'; // Pastikan path-nya sesuai



void main() {
  runApp(const MaterialApp(
    home: ProfilPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
  if (index == _selectedIndex) return;
  switch (index) {
    case 0:
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
      break;
    case 1:
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => KonsultasiPage()));
      break;
    case 2:
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RoomChatPage()));
      break;
    case 3:
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfilPage()));
      break;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 244, 244),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 185, 29, 18),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Konsultasi'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Room Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
  
      body: Column(
        children: [
          // Header dengan warna merah
          Container(
            color: Colors.red[800],
            padding: const EdgeInsets.only(top: 60, bottom: 40, left: 20, right: 20),
            width: double.infinity,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/user_profile.jpg'), // ganti dengan path gambar kamu
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Andhika Pratama",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Siswa",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                )
              ],
            ),
          ),

          // Informasi Personal
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Informasi Personal", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _buildInfoRow("NISN", "2304664"),
                _buildInfoRow("Kelas", "11 IPA 5"),
                _buildInfoRow("Telepon", "085725456023"),
                _buildInfoRow("Email", "andhika.p@student.ac.id"),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text("Edit Profil"),
                )
              ],
            ),
          ),

          // Riwayat Aktivitas
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Riwayat Aktivitas", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _buildActivityCard(
                  title: "Konseling Terakhir",
                  date: "20 Feb 2024",
                  description: "Konseling Akademik dengan Hernika P., S.Psi",
                ),
                const SizedBox(height: 8),
                _buildActivityCard(
                  title: "Assessment Terakhir",
                  date: "15 Feb 2024",
                  description: "Evaluasi Kemajuan Akademik",
                ),
              ],
            ),
          ),

          const Spacer(),

          // Tombol Keluar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red[50],
                foregroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Konfirmasi Keluar"),
                    content: const Text("Yakin ingin keluar?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Batal"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                            (route) => false,
                          );
                        },
                        child: const Text("Keluar"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text("Keluar"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildActivityCard({required String title, required String date, required String description}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(date, style: const TextStyle(color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 4),
          Text(description),
        ],
      ),
    );
  }
}
