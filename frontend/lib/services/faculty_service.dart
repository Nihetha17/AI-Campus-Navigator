import '../models/faculty_model.dart';

class FacultyService {
  List<Faculty> getFaculty() {
    return [
      Faculty(
        name: "Dr Kumar",
        department: "CSE",
        cabin: "Room 205",
        email: "kumar@college.edu",
      ),
      Faculty(
        name: "Dr Priya",
        department: "AIML",
        cabin: "Room 301",
        email: "priya@college.edu",
      ),
      Faculty(
        name: "Dr Rajesh",
        department: "ECE",
        cabin: "Room 112",
        email: "rajesh@college.edu",
      ),
    ];
  }
}
