import 'package:flutter/material.dart';
import 'package:proyek_3/home.dart';
import 'package:proyek_3/konsultasi.dart';
import 'package:proyek_3/profil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RoomChatPage(),
    );
  }
}

class RoomChatPage extends StatefulWidget {
  const RoomChatPage({super.key});

  @override
  State<RoomChatPage> createState() => _RoomChatPageState();
}

class _RoomChatPageState extends State<RoomChatPage> {
  int _selectedIndex = 2;

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
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          'Room Chat',
          style: TextStyle(color: const Color.fromARGB(255, 151, 13, 13)),
        ),
        backgroundColor: const Color.fromARGB(10, 0, 0, 0),
        elevation: 2,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(33, 0, 0, 0),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60), // atur jarak dari kiri
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.red.shade900,
                      child: Icon(Icons.search, color: Colors.white, size: 28),
                    ),
                  )
                ],
              ),
            ),
          ),

          // Chat List
          Expanded(
            child: ListView(
              children: [
                ChatTile(
                  color: Colors.indigo.shade900,
                  name: 'Hernika Prihatina., S.Psi',
                  message: 'Ibu saya mau dateng ke ruang BK',
                  unreadCount: 0,
                ),
                ChatTile(
                  color: Colors.pink.shade300,
                  name: 'Lupita P., S.Pd',
                  message: 'Semangat YAA!!',
                  unreadCount: 1,
                ),
              ],
            ),
          ),
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

class ChatTile extends StatelessWidget {
  final Color color;
  final String name;
  final String message;
  final int unreadCount;

  const ChatTile({
    required this.color,
    required this.name,
    required this.message,
    this.unreadCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatPage(
              chatRoomId: 'room_1', // nanti bisa kamu ganti dinamis
              currentUserId: 'uid1', // ganti pakai FirebaseAuth.instance.currentUser!.uid
              peerName: name,
              peerColor: color,
            ),
          ),
        );
      },
      leading: CircleAvatar(
        backgroundColor: color,
      ),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(message),
      trailing: unreadCount > 0
          ? Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.red.shade900,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$unreadCount',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            )
          : null,
    );
  }
}


class ChatPage extends StatefulWidget {
  final String chatRoomId;
  final String currentUserId;
  final String peerName;
  final Color peerColor;

  const ChatPage({
    super.key,
    required this.chatRoomId,
    required this.currentUserId,
    required this.peerName,
    required this.peerColor,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: widget.peerColor,
              radius: 16,
            ),
            const SizedBox(width: 8),
            Text(
              widget.peerName,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(widget.chatRoomId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Terjadi error: ${snapshot.error}'),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return MessageBubble(
                      text: msg['text'] ?? '',
                      isSender: msg['senderId'] == widget.currentUserId,
                    );
                  },
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Ketik pesan...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.red.shade900),
                  onPressed: () async {
                    final messageText = _messageController.text.trim();
                    if (messageText.isNotEmpty) {
                      try {
                        await FirebaseFirestore.instance
                            .collection('chats')
                            .doc(widget.chatRoomId)
                            .collection('messages')
                            .add({
                          'text': messageText,
                          'senderId': widget.currentUserId,
                          'timestamp': FieldValue.serverTimestamp(),
                        });

                        _messageController.clear();
                      } catch (e) {
                        debugPrint('❌ Gagal mengirim pesan: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Gagal mengirim pesan.')),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isSender;

  const MessageBubble({super.key, required this.text, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSender ? Colors.red.shade700 : Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isSender ? 16 : 0),
            bottomRight: Radius.circular(isSender ? 0 : 16),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSender ? Colors.white : Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
