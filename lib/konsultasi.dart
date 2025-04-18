import 'package:flutter/material.dart';
import 'package:proyek_3/home.dart';
import 'package:proyek_3/profil.dart';
import 'package:proyek_3/roomchat.dart';

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

  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.person, 'label': 'Pribadi', 'active': true},
    {'icon': Icons.group, 'label': 'Sosial'},
    {'icon': Icons.bar_chart, 'label': 'Karier'},
    {'icon': Icons.menu_book, 'label': 'Akademik'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 234, 234),
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        centerTitle: true,
        title: const Text("Konsultasi", 
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          )
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                  child: Image.asset(
                    'assets/img/gambar konsul.png', 
                    fit: BoxFit.cover,
                  ),
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
                      'Temukan Solusi Bersama\n Guru BK',
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
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: categories.map((item) {
                bool isActive = item['label'] == 'Pribadi';
                return Container(
                  width: (MediaQuery.of(context).size.width - 72) / 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      )
                    ],
                  ),
                  child: Material(
                    color: isActive ? Colors.red[800] : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item['icon'], color: isActive ? Colors.white : Colors.red[800], size: 32),
                            const SizedBox(height: 8),
                            Text(
                              item['label'],
                              style: TextStyle(
                                color: isActive ? Colors.white : Colors.red[800],
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
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
    );
  }
}
