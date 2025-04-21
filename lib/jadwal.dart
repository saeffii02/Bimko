import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
      home: const JadwalKonselingPage(),
    );
  }
}

class JadwalKonselingPage extends StatefulWidget {
  const JadwalKonselingPage({super.key});

  @override
  State<JadwalKonselingPage> createState() => _JadwalKonselingPageState();
}

class _JadwalKonselingPageState extends State<JadwalKonselingPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime(2025, 3, 6);
  DateTime? _selectedDay;

  final List<DateTime> availableDates = [
    DateTime(2025, 3, 6),
    DateTime(2025, 3, 10),
    DateTime(2025, 3, 20),
    DateTime(2025, 3, 28),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD32F2F),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD32F2F),
        elevation: 0,
        centerTitle: true,
        leading: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        title: const Text(
          'Jadwal Konseling',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          _buildCalendar(context),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(24, 24, 24, 8),
                    child: Text(
                      'Jadwal Saya',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child
                          : ListView(
                              padding: const EdgeInsets.only(bottom: 20),
                              children: [
                                _buildScheduleCard(
                                  color: const Color(0xFFFF6B6B),
                                  title: 'Sesi Konsultasi Sosial',
                                  time: '10.00 AM - 12.00 PM',
                                  counselor: 'Hernika P., S.Psi',
                                  room: 'Ruang BK',
                                  icon: Icons.group_outlined,
                                ),
                                _buildScheduleCard(
                                  color: const Color(0xFFFFA63D),
                                  title: 'Sesi Konsultasi Karier',
                                  time: '13.00 PM - 14.30 PM',
                                  counselor: 'Hernika P., S.Psi',
                                  room: 'Ruang BK',
                                  icon: Icons.work_outline,
                                ),
                                _buildScheduleCard(
                                  color: const Color(0xFF8187F8),
                                  title: 'Sesi Konsultasi Akademik',
                                  time: '15.00 PM - 16.00 PM',
                                  counselor: 'Hernika P., S.Psi',
                                  room: 'Ruang BK',
                                  icon: Icons.school_outlined,
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Konsultasi'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: 'Room Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }

  Widget _buildCalendar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.50,
          child: TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() => _calendarFormat = format);
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekendStyle: TextStyle(color: Color(0xFFD32F2F)),
            ),
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB71C1C),
              ),
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: const Color(0xFF8187F8).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: const Color(0xFFB71C1C),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.redAccent.withOpacity(0.4),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              selectedTextStyle: const TextStyle(color: Colors.white),
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, _) {
                if (day.month == 3) {
                  if (day.day == 6) {
                    return _customDateBubble(day, Colors.pink.shade100, Colors.red);
                  } else if (day.day == 10) {
                    return _customDateBubble(day, Colors.orange.shade200, Colors.black);
                  } else if (day.day == 20) {
                    return _customDateBubble(day, const Color(0xFF8187F8), Colors.white);
                  } else if (day.day == 28) {
                    return _customDateBubble(day, Colors.green.shade400, Colors.white);
                  }
                }
                return null;
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _customDateBubble(DateTime day, Color bgColor, Color textColor) {
    return Center(
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '${day.day}',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleCard({
    required Color color,
    required String title,
    required String time,
    required String counselor,
    required String room,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            counselor,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                time,
                style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13),
              ),
              Text(
                room,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
