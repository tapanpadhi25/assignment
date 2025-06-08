import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../models/projects_model.dart'; // Ensure your Project model has `name` and `location` fields

class MapScreen extends StatefulWidget {
  final List<Project> allProjects; // All sample projects to show on the map

  const MapScreen({super.key, required this.allProjects});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _currentLatLng;
  final List<Marker> _markers = [];
  final List<Polyline> _polylines = [];

  @override
  void initState() {
    super.initState();
    _initializeMapData();
  }

  Future<void> _initializeMapData() async {
    final position = await _determinePosition();
    if (position == null) return;

    final currentLatLng = LatLng(position.latitude, position.longitude);
    final markers = <Marker>[
      Marker(
        point: currentLatLng,
        width: 40,
        height: 40,
        child: Icon(Icons.my_location, color: Colors.blue),
      ),
    ];

    for (var project in widget.allProjects) {
      final LatLng projectLatLng = LatLng(
        project.location.latitude,
        project.location.longitude,
      );

      markers.add(
        Marker(
          point: projectLatLng,
          width: 40,
          height: 40,
          child:GestureDetector(
            onTap: () => _openProjectDetails(project),
            child: const Icon(Icons.location_on, color: Colors.red, size: 35),
          ) ,
        ),
      );
    }

    setState(() {
      _currentLatLng = currentLatLng;
      _markers.clear();
      _markers.addAll(markers);
    });
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  void _openProjectDetails(Project project) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Project Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Name: ${project.name}"),
              Text("Amount: ₹${project.amount}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // close dialog
              child: const Text("Close"),
            ),

          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentLatLng == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
        options: MapOptions(
          initialCenter: _currentLatLng!,
          initialZoom: 13,
          maxZoom: 18,
          minZoom: 5,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(markers: _markers),
          if (_polylines.isNotEmpty)
            PolylineLayer(polylines: _polylines),
        ],
      ),
    );
  }
}
