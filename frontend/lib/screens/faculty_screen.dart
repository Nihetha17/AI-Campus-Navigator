import 'package:flutter/material.dart';
import '../services/faculty_service.dart';
import 'faculty_details_screen.dart';

class FacultyScreen extends StatefulWidget {
  const FacultyScreen({super.key});

  @override
  State<FacultyScreen> createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
  final FacultyService facultyService = FacultyService();

  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final facultyList = facultyService.getFaculty();

    final filteredFaculty = facultyList.where((faculty) {
      return faculty.name.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Faculty Search")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: "Search Faculty...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: filteredFaculty.length,
                itemBuilder: (context, index) {
                  final faculty = filteredFaculty[index];

                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(faculty.name),
                      subtitle: Text(faculty.department),
                      trailing: const Icon(Icons.arrow_forward_ios),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                FacultyDetailsScreen(faculty: faculty),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
