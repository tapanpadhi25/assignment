import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  final String id;
  final String name;
  final String description;
  final GeoPoint location;
  final int amount;
  final List<String> images;
  final List<String> videos;
  final Map<String, int> chatStats;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.amount,
    required this.images,
    required this.videos,
    required this.chatStats,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      description: json['description']??"",
      location: json['location'],
      amount: json['amount'],
      images: List<String>.from(json['images'] ?? []),
      videos: List<String>.from(json['videos'] ?? []),
      chatStats: Map<String, int>.from(json['chatStats'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'name': name,
      "description":description,
      'location': location,
      'amount': amount,
      'images': images,
      'videos': videos,
      'chatStats': chatStats,
    };
  }
}
