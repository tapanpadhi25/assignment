import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BakeryCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const BakeryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              item['image'],
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          // Text Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  item['cuisine'],
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                ),
                Text(
                  '${item['location']} | ${item['distance']}',
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Chip(
                      label: const Text(
                        'Top Store',
                        style: TextStyle(fontSize: 8, color: Colors.white),
                      ),
                      backgroundColor: Colors.grey[400],
                      visualDensity: VisualDensity.compact,
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                    ),
                  ],
                ),
                const Divider(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.percent, size: 16, color: Colors.red),
                    const SizedBox(width: 4),
                    Text(
                      item['offer'],
                      style: const TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.percent, size: 16, color: Colors.red),
                    const SizedBox(width: 4),
                    const Expanded(
                      child: Text(
                        "3400+ items available",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Rating & Time
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.grey, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    item['rating'],
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                item['time'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
