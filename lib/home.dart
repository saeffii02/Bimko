import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:proyek_3/konsultasi.dart';
import 'package:proyek_3/profil.dart';
import 'package:proyek_3/roomchat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

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
      backgroundColor: const Color.fromARGB(255, 151, 22, 13),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  _buildMenuGrid(),
                  const SizedBox(height: 75), // 👈 Tambahkan jarak di sini
                  _buildUpcomingSchedule(),
                  const SizedBox(height: 90),
                  _buildStatistics(),
                  const SizedBox(height: 24),
                  _buildLatestArticles(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
  return Container(
    width: double.infinity,
    decoration: const BoxDecoration(
    ),
    child: Stack(
      children: [
        // Gambar dekoratif di kanan bawah
        Positioned(
          left: 360,
          top: 2,
          child: Image.asset(
            "assets/img/icon_header.png", // Ganti dengan path gambar buku kamu
            width: 300,
            height: 390,
          ),
        ),

        // Icon notifikasi di kanan atas
        Positioned(
          top: 40,
          right: 20,
          child: Icon(
            Icons.notifications,
            color: Colors.white70,
            size: 28,
          ),
        ),

        // Teks dan logo BIMKO
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "BIMKO",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ProtestGuerrilla', // pastikan font sudah ada
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Halo, SMANSASI!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Mukta-Medium',
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Pantau jadwal konseling, pengaduan, \ndan berita terbaru di sini",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}



  Widget _buildMenuGrid() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.7,
        ),
        children: [
          _MenuCard(imagePath: "assets/img/pengaduan.png", label: "Pengaduan", description: "Laporkan keluhan atau masalah."),
          _MenuCard(imagePath: "assets/img/calendar.png", label: "Jadwal Konseling", description: "Lihat jadwal konseling."),
          _MenuCard(imagePath: "assets/img/konsultasi.png", label: "Konsultasi", description: "Ajukan sesi konseling di sini."),
          _MenuCard(imagePath: "assets/img/assessment.png", label: "Assessment", description: "Lakukan penilaian diri."),
          _MenuCard(imagePath: "assets/img/news.png", label: "News", description: "Berita terbaru seputar sekolah."),
          _MenuCard(imagePath: "assets/img/alumni.png", label: "Track Alumni", description: "Lacak perkembangan alumni."),
        ],
      ),
    );
  }

  Widget _buildUpcomingSchedule() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Jadwal Terdekat",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 10),
        _ScheduleCardRedesign(
          name: "Hernika P., S.Psi",
          role: "Konselor Akademik",
          time: "12.00 - 14.00 WIB",
          imageAsset: "assets/img/konselor.png", // ganti sesuai asset kamu
        ),
      ],
    ),
  );
}


  Widget _buildStatistics() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Statistik Konseling",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 1),
                    FlSpot(1, 3),
                    FlSpot(2, 2),
                    FlSpot(3, 5),
                    FlSpot(4, 4),
                  ],
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 4,
                  belowBarData: BarAreaData(show: false),
                  dotData: FlDotData(show: true),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildLatestArticles() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 90),
        Text(
          "Artikel Terbaru",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 10),
        _ArticleCard(title: "Tips Mengatasi Stres di Sekolah"),
      ],
    ),
  );
}

}

class _MenuCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final String description;

  const _MenuCard({
    required this.imagePath,
    required this.label,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 12), // Jarak antara deskripsi dan ikon
              Image.asset(
                imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class _ScheduleCardRedesign extends StatelessWidget {
  final String name;
  final String role;
  final String time;
  final String imageAsset;

  const _ScheduleCardRedesign({
    required this.name,
    required this.role,
    required this.time,
    required this.imageAsset,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            const Color.fromARGB(255, 178, 29, 19).withOpacity(0.1),
            const Color.fromARGB(255, 172, 60, 60),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 248, 228, 226).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Gambar konselor
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              imageAsset,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          // Teks tengah
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 250, 249, 249), // merah gelap
                  ),
                ),
                Text(
                  role,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(185, 255, 255, 255),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Color.fromARGB(159, 182, 29, 18)),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(97, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Badge "Hari ini"
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFF9B1C1C), // warna merah
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              "Hari ini",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}




class _ArticleCard extends StatelessWidget {
  final String title;

  const _ArticleCard({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          // Aksi ketika artikel diklik, misalnya navigasi
        },
        child: Row(
          children: [
            // Gambar thumbnail
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.asset(
                'assets/img/artikel.jpg', // Ganti dengan gambar artikel
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            // Konten teks
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9B1C1C),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Pelajari cara sederhana mengelola stres agar tetap fokus dan bahagia di sekolah.",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
