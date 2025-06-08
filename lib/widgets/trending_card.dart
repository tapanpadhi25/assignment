import 'package:flutter/material.dart';

class TrendingCard extends StatelessWidget {
  final String imagePath;

  const TrendingCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.35,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with fixed width
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 80,
                height: 90,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Text Info
            const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mithas Bhandar',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Sweets, North Indian\n(store location) | 6.4 kms',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, size: 14, color: Colors.orange),
                        SizedBox(width: 4),
                        Text('4.1'),
                        SizedBox(width: 8),
                        Text('|'),
                        SizedBox(width: 8),
                        Text('45 mins'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
