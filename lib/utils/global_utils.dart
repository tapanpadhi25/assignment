import 'package:dio/dio.dart';

Dio getDio(){
  var dio = Dio();
  return dio;
}

final List<String> imagePaths = [
  'assets/images/slider_image.png',
  'assets/images/slider_image.png',
  'assets/images/slider_image.png',
];final List<String> imagePath = [
  'assets/images/craze_image.png',
  'assets/images/craze_image.png',
  'assets/images/craze_image.png',
];

final List<Map<String, dynamic>> bakeryData = [
  {
    'image': 'assets/images/bakery.png',
    'name': 'Freshly Baker',
    'cuisine': 'Sweets, North Indian',
    'location': 'Site No -1',
    'distance': '6.4 kms',
    'rating': '4.1',
    'time': '45 mins',
    'offer': 'Upto 10% OFF',
  },
  {
    'image': 'assets/images/bakery.png',
    'name': 'Freshly Baker',
    'cuisine': 'Sweets, North Indian',
    'location': 'Site No -1',
    'distance': '6.4 kms',
    'rating': '4.1',
    'time': '45 mins',
    'offer': 'Upto 10% OFF',
  },
];