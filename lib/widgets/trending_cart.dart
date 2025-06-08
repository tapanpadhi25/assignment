import 'package:assignment/widgets/trending_card.dart';
import 'package:flutter/material.dart';

class TrendingCart extends StatefulWidget {
  const TrendingCart({super.key});

  @override
  State<TrendingCart> createState() => _TrendingCartState();
}

class _TrendingCartState extends State<TrendingCart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.28,
      // width: ,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4, // 2 columns x 2 rows
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // two rows
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.45, // Adjust for proper sizing
        ),
        itemBuilder: (context, index) {
          return TrendingCard(imagePath: 'assets/images/ice_cream.png');
        },
      ),
    );
  }
}
