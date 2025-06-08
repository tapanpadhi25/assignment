import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> preloadProjectsToFirestore() async {
  final firestore = FirebaseFirestore.instance;
  final projectCollection = firestore.collection('projects');
  final existing = await projectCollection.get();
  for (var doc in existing.docs) {
    await doc.reference.delete();
  }
  final projects = [
    {'id':"1",
      'name': 'Green Park Renovation',
      'description': 'Revamp the city park with greener spaces, benches, and LED lighting.',
      'location': const GeoPoint(12.9166, 77.6101),
      'amount': 100000,
      'images': [],
      'videos': [],
      'chatStats': {'positive': 40, 'neutral': 30, 'negative': 30},
    },
    {'id':"2",
      'name': 'City Metro Expansion',
      'description': 'Expand the metro line to connect more suburbs with the city center.',
      'location': const GeoPoint(12.9592, 77.6974),
      'amount': 250000,
      'images': [],
      'videos': [],
      'chatStats': {'positive': 60, 'neutral': 20, 'negative': 20},
    },
    {'id':"3",
      'name': 'Smart Lighting Project',
      'description': 'Upgrade pipelines and treatment facilities to improve water delivery.',
      'location': const GeoPoint(12.9719, 77.6412),
      'amount': 75000,
      'images': [],
      'videos': [],
      'chatStats': {'positive': 50, 'neutral': 30, 'negative': 20},
    },
    {'id':"4",
      'name': 'Water Supply Modernization',
      'description': 'Installation of energy-efficient smart lights throughout urban roads.',
      'location': const GeoPoint(12.9250, 77.5938),
      'amount': 180000,
      'images': [],
      'videos': [],
      'chatStats': {'positive': 45, 'neutral': 35, 'negative': 20},
    },
    {'id':"5",
      'name': 'Public WiFi Project',
      'description': 'Deploy high-speed WiFi in public areas for citizens and tourists.',
      'location': const GeoPoint(12.9352, 77.6140),
      'amount': 120000,
      'images': [],
      'videos': [],
      'chatStats': {'positive': 55, 'neutral': 25, 'negative': 20},
    },
    {'id':"6",
      'name': 'Solar Panel Deployment',
      'description': 'Install solar panels on government buildings to reduce energy costs.',
      'location': const GeoPoint(12.9784, 77.5726),
      'amount': 200000,
      'images': [],
      'videos': [],
      'chatStats': {'positive': 65, 'neutral': 20, 'negative': 15},
    },
  ];
  for (var project in projects) {
    await projectCollection.add(project);
  }
}


Future<String?> downloadFileFromUrl(String url) async {
  try {
    final fileName = url.split('/').last.split('?').first; // Remove query params if any

    Directory? baseDir;

    if (Platform.isAndroid) {
      final dirs = await getExternalStorageDirectories(type: StorageDirectory.downloads);
      if (dirs != null && dirs.isNotEmpty) {
        baseDir = dirs.first;
      } else {
        print('Downloads directory not found on Android.');
        return null;
      }
    } else if (Platform.isIOS) {
      baseDir = await getApplicationDocumentsDirectory();
    } else {
      baseDir = await getApplicationDocumentsDirectory();
    }

    if (!await baseDir.exists()) {
      await baseDir.create(recursive: true);
    }

    final filePath = '${baseDir.path}/$fileName';

    final dio = Dio();
    final response = await dio.download(
      url,
      filePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          print('Downloading: ${(received / total * 100).toStringAsFixed(0)}%');
        }
      },
    );

    if (response.statusCode == 200) {
      print('File successfully downloaded at: $filePath');
      return filePath;
    } else {
      print('Download failed with status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error while downloading file: $e');
    return null;
  }
}
