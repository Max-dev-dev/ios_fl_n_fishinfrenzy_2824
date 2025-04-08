import 'package:flutter/material.dart';

class RatingScreen extends StatelessWidget {
  RatingScreen({super.key});

  final List<Map<String, dynamic>> fishRatings = [
    {
      'name': 'Golden Moray Eel',
      'image': 'assets/images/fish/1.png',
      'rating': 5,
    },
    {'name': 'Blue Shark', 'image': 'assets/images/fish/2.png', 'rating': 4},
    {'name': 'Moon Fish', 'image': 'assets/images/fish/4.png', 'rating': 4},
    {'name': 'Sea Dragon', 'image': 'assets/images/fish/5.png', 'rating': 5},
    {'name': 'Silver Marlin', 'image': 'assets/images/fish/6.png', 'rating': 3},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Mini-games.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(context, 'Rating'),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: fishRatings.length,
                  itemBuilder: (context, index) {
                    final fish = fishRatings[index];
                    return _buildRatingTile(fish['name'], fish['image'], index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingTile(String fishName, String imagePath, int index) {
    return Center(
      child: Card(
        color: const Color(0xFF002D67),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Text(
                  '${index + 1}',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(width: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    width: 80,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  fishName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/back_btn.png',
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
