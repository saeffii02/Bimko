import 'package:flutter/material.dart';
import 'package:proyek_3/home.dart';
import 'package:proyek_3/profil.dart';
import 'package:proyek_3/roomchat.dart';
import 'package:proyek_3/form_konsultasi.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: KonsultasiPage(),
  ));
}

class KonsultasiPage extends StatefulWidget {
  const KonsultasiPage({Key? key}) : super(key: key);

  @override
  State<KonsultasiPage> createState() => _KonsultasiPageState();
}

class _KonsultasiPageState extends State<KonsultasiPage> {
  int _selectedIndex = 1;
  String _selectedCategory = '';

  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.person, 'label': 'Pribadi'},
    {'icon': Icons.group, 'label': 'Sosial'},
    {'icon': Icons.bar_chart, 'label': 'Karier'},
    {'icon': Icons.menu_book, 'label': 'Akademik'},
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomePage()));
        break;
      case 1:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => KonsultasiPage()));
        break;
      case 2:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => RoomChatPage()));
        break;
      case 3:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => ProfilPage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEAEA),
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          "Konsultasi",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, // Ubah warna teks judul
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                  child: Image.asset(
                    'assets/img/gambar konsul.png',
                    height: 280,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const Positioned(
                  bottom: 20,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Temukan Solusi Bersama\nGuru BK',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          fontFamily: 'Roboto',
                          shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Tidak perlu menghadapi semuanya sendirian. Mari bicarakan bersama \ndalam sesi konseling—karena setiap masalah pasti ada solusinya!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Rhodium Libre',
                          shadows: [Shadow(blurRadius: 2, color: Colors.black)],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double itemWidth = (constraints.maxWidth - 16) / 2;

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: categories.map((item) {
                      bool isActive = _selectedCategory == item['label'];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = item['label'];
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BuatKonsultasiPage(
                                kategori: item['label'],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: itemWidth,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: isActive ? Colors.red[800] : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 6,
                                offset: const Offset(2, 4),
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                item['icon'],
                                color: isActive ? Colors.white : Colors.red[800],
                                size: 32,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item['label'],
                                style: TextStyle(
                                  color:
                                      isActive ? Colors.white : Colors.red[800],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 185, 29, 18),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Konsultasi'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Room Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
