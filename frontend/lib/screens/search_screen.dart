import 'package:flutter/material.dart';
import '../models/location_model.dart';
import '../services/location_service.dart';
import 'location_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = '';

  final LocationService _locationService = LocationService();

  @override
  Widget build(BuildContext context) {
    final locations = _locationService.getLocations();

    final filteredLocations = locations.where((location) {
      return location.name.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Search Locations')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search location...',
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
                itemCount: filteredLocations.length,
                itemBuilder: (context, index) {
                  final location = filteredLocations[index];

                  return Card(
                    child: ListTile(
                      title: Text(location.name),

                      subtitle: Text('${location.block} • ${location.floor}'),
                      trailing: const Icon(Icons.arrow_forward_ios),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                LocationDetailsScreen(location: location),
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
