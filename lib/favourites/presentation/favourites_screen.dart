import 'package:flutter/material.dart';
import 'package:gemini_chat_bot/home/presentation/home_screen.dart';
import 'package:gemini_chat_bot/navigation_bar/navigation_bar_screen.dart';
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  NavigationBarSection()),
            );},
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Favorites",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 36),
            Image.asset('assets/images/favIcon.png',width: 22,height: 22,),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // List of Favorite Items
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Number of cards
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: FavoriteCard(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:270,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage('assets/images/mountain.jpg'), // Replace with your image asset
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Favorite Icon
          Positioned(
            top: 10,
            right: 10,
            child: Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 28,
            ),
          ),
          // Text Information
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About PACE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children:
                  [
                    Text(
                      'Intro video about pace',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(width: 145),
                    Icon(Icons.access_time, color: Colors.white70, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '6:00',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}