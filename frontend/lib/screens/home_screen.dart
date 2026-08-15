import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'faculty_screen.dart';
import 'campus_map_screen.dart';
import 'chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget buildCard(BuildContext context, IconData icon, String title) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Icon(icon, size: 35),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          if (title == "Search Locations") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
          } else if (title == "Faculty Search") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FacultyScreen()),
            );
          } else if (title == "Campus Map") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CampusMapScreen()),
            );
          } else if (title == "AI Assistant") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChatScreen()),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Campus Navigator')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildCard(context, Icons.search, "Search Locations"),
            buildCard(context, Icons.chat, "AI Assistant"),
            buildCard(context, Icons.map, "Campus Map"),
            buildCard(context, Icons.people, "Faculty Search"),
          ],
        ),
      ),
    );
  }
}
