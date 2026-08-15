import 'package:flutter/material.dart';
import '../models/location_model.dart';

class DirectionsScreen extends StatelessWidget {
  final Location location;

  const DirectionsScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Directions")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          child: Padding(
            
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Text(location.directions, style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
