import 'package:assignment/constants/theme.dart';
import 'package:assignment/screens/notification_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../model/menu_item.dart';
import '../utils/global_utils.dart';
import '../widgets/bakery_card.dart';
import '../widgets/trending_card.dart';
import '../widgets/trending_cart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _locations = ['ABCD, New Delhi'];
  String _selectedLocation = 'ABCD, New Delhi';
  final List<MenuItem> items = [
    MenuItem("Food Delivery", "assets/images/food_delivery.png", true),
    MenuItem("Medicines", "assets/images/medicines.png", true),
    MenuItem("Pet Supplies", "assets/images/pet_supplies.png", true),
    MenuItem("Gifts", "assets/images/gifts.png", false),
    MenuItem("Meat", "assets/images/meat.png", false),
    MenuItem("Cosmetic", "assets/images/cosmetic.png", false),
    MenuItem("Stationery", "assets/images/stationery.png", false),
    MenuItem("Stores", "assets/images/stores.png", true),
  ];

  @override
  Widget build(BuildContext context) {
    var themeData = CustomTheme.getTheme(true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.green),
                const SizedBox(width: 4),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedLocation,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                        color: Colors.green),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    items: _locations.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLocation = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search for products/stores",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        Icon(Icons.search, color: Colors.green),
                      ],
                    ),
                  ),
                ),
                // const Expanded(flex: 1, child: SizedBox()),

                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const NotificationScreen()));
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(Icons.notifications_none_outlined,
                            color: Colors.red, size: 33),
                        Positioned(
                          right: 10,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                                minWidth: 16, minHeight: 16),
                            child: const Center(
                              child: Text(
                                '2',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Expanded(
                  flex: 1,
                  child: Icon(Icons.local_offer_outlined,
                      color: Colors.orange, size: 30),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "What would you like to do today?",
              style: themeData!.textTheme.titleLarge,
            ),
            const SizedBox(height: 5),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.7,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _MenuTile(item: items[index]);
              },
            ),
            Center(
              child: InkWell(
                onTap: () {},
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "More",
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.green,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text("Top picks for you", style: themeData.textTheme.titleMedium),
            const SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1.0,
              ),
              items: imagePaths.map((path) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(path, fit: BoxFit.cover),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Trending',
                  style: themeData.textTheme.titleMedium,
                ),
                Text(
                  'See all',
                  style: themeData.textTheme.titleSmall!.copyWith(
                      color: Colors.green, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            // SizedBox(
            //   height: MediaQuery.sizeOf(context).height*0.27,
            //   child: ListView.builder(
            //     // scrollDirection: Axis.horizontal,
            //     itemCount: 4,
            //     itemBuilder: (context, index) {
            //       return Padding(
            //         padding: const EdgeInsets.only(right: 8.0),
            //         child: TrendingCard(imagePath: 'assets/images/ice_cream.png'),
            //       );
            //     },
            //   ),
            // ),
            TrendingCart(),
            Text(
              "Craze deals",
              style: themeData.textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            CarouselSlider(
              options: CarouselOptions(
                height: 150,
                autoPlay: true,
                enlargeCenterPage: false,
                viewportFraction: 0.9,
              ),
              items: imagePath.map((path) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(path, fit: BoxFit.cover),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/images/refer.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nearby stores',
                  style: themeData.textTheme.titleMedium,
                ),
                Text(
                  'See all',
                  style: themeData.textTheme.titleSmall!.copyWith(
                      color: Colors.green, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = bakeryData[index];
                  return BakeryCard(item: item);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemCount: bakeryData.length),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {},
                  child: Text(
                    "View All Stores",
                    style: themeData.textTheme.titleMedium!
                        .copyWith(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final MenuItem item;

  const _MenuTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 2,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(item.imagePath, height: 40),
              ),
            ),
            Text(item.title, textAlign: TextAlign.center),
          ],
        ),
        if (item.hasDiscount)
          Positioned(
            top: 4,
            left: 4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '10% Off',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
