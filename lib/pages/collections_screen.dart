import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_f_n_fishinfrenzy_2824/cubit/fish_cubit.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});

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
              _buildTopBar(context, 'Collections'),
              Expanded(
                child: BlocBuilder<FishCubit, List<String>>(
                  builder: (context, fishCollection) {
                    if (fishCollection.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "You haven't caught any fish yet!",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: fishCollection.length,
                      itemBuilder: (context, index) {
                        return _buildFishCard(fishCollection[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFishCard(String fishName) {
    String imagePath = _getFishImagePath(fishName);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF002D67),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                fishName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getFishImagePath(String fishName) {
    final fishMap = {
      'Golden Moray Eel': 'assets/images/fish/1.png',
      'Blue Shark': 'assets/images/fish/2.png',
      'Moon Fish': 'assets/images/fish/4.png',
      'Sea Dragon': 'assets/images/fish/5.png',
      'Silver Marlin': 'assets/images/fish/6.png',
    };
    return fishMap[fishName] ?? 'assets/images/fish/1.png';
  }

  Widget _buildTopBar(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/home_btn.png',
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
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/rating');
            },
            child: const Text(
              'Rating',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF9BE28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
