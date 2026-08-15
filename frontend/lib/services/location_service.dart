import '../models/location_model.dart';

class LocationService {
  List<Location> getLocations() {
    return [
      Location(
        name: "Library",
        block: "Main Block",
        floor: "Ground Floor",
        room: "L01",
        directions:
            "Walk straight from the main gate for 100 meters and turn left near the Admin Block.",
      ),
      Location(
        name: "CSE Lab 1",
        block: "CSE Block",
        floor: "1st Floor",
        room: "101",
        directions:
            "Enter the CSE Block and take the stairs to the first floor.",
      ),
      Location(
        name: "CSE Lab 2",
        block: "CSE Block",
        floor: "1st Floor",
        room: "102",
        directions:
            "Enter the CSE Block and proceed to Room 102 on the first floor.",
      ),
      Location(
        name: "Seminar Hall",
        block: "Admin Block",
        floor: "2nd Floor",
        room: "SH1",
        directions:
            "Go to the Admin Block and take the stairs to the second floor.",
      ),
    ];
  }
}
