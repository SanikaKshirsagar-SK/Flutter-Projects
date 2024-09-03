import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_player_app/widgets/style_widget.dart';
import '../model/song_model.dart';
import 'play_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<SongModel> songsList = [
    SongModel(
      songName: "Dil Bechara",
      songUrl: "Dil Bechara.mp3",
      songImg: "assets/images/Dil Bechara.jpg", // Add the image URL
      songArtist: "A.R. Rahman",
      songCategory: "Hindi Songs",
      songYear: "2020",
      isFav: false, // Initialize isFav to false
    ),
    SongModel(
      songName: "Besabriyaan",
      songUrl: "Besabriyaan.mp3",
      songImg: "assets/images/Besabriyaan.jpg", // Add the image URL
      songArtist: "Armaan Malik",
      songCategory: "Hindi Songs",
      songYear: "2016",
      isFav: false, // Initialize isFav to false
    ),
    SongModel(
      songName: "Chaar Kadam",
      songUrl: "Chaar Kadam.mp3",
      songImg: "assets/images/Chaar Kadam.jpg", // Add the image URL
      songArtist: "Shreya Ghoshal, Shaan",
      songCategory: "Hindi Songs",
      songYear: "2014",
      isFav: false, // Initialize isFav to false
    ),

    SongModel(
      songName: "Jaane Woh Kaise",
      songUrl: "Jaane Woh Kaise.mp3",
      songImg: "assets/images/Jaane Woh Kaise.jpg", // Add the image URL
      songArtist: "Sanam, S. D. Burman",
      songCategory: "Old Songs",
      songYear: "1964",
      isFav: false, // Initialize isFav to false
    ),
    SongModel(
      songName: "Kuch Na Kaho",
      songUrl: "Kuch Na Kaho.mp3",
      songImg: "assets/images/Kuch Na Kaho.jpg", // Add the image URL
      songArtist: "Sanam, Shirley Setia, R. D. Burman",
      songCategory: "Old Songs",
      songYear: "1975",
      isFav: false, // Initialize isFav to false
    ),
    SongModel(
      songName: "Abhi Na Jao Chhod Kar",
      songUrl: "Abhi Na Jao Chhod Kar.mp3",
      songImg: "assets/images/Abhi Na Jao Chhod Kar.jpg", // Add the image URL
      songArtist: "Pritam, Shashwat Singh",
      songCategory: "Old Songs",
      songYear: "1961",
      isFav: false, // Initialize isFav to false
    ),
    SongModel(
      songName: "Lag Jaa Gale",
      songUrl: "Lag Jaa Gale.mp3",
      songImg: "assets/images/Lag Jaa Gale.jpg", // Add the image URL
      songArtist: "Sanam",
      songCategory: "Old Songs",
      songYear: "1964",
      isFav: false, // Initialize isFav to false
    ),
    // English Songs
    SongModel(
      songName: "Perfect",
      songUrl: "Perfect.mp3",
      songImg: "assets/images/Perfect.jpg", // Add the image URL
      songArtist: "Ed Sheeran",
      songCategory: "English Songs",
      songYear: "2017",
      isFav: false, // Initialize isFav to false
    ),
    SongModel(
      songName: "Shape of You",
      songUrl: "Shape-of-You.mp3",
      songImg: "assets/images/Shape of You.jpg", // Add the image URL
      songArtist: "Ed Sheeran",
      songCategory: "English Songs",
      songYear: "2017",
      isFav: false, // Initialize isFav to false
    ),
    SongModel(
      songName: "Memories",
      songUrl: "Memories.mp3",
      songImg: "assets/images/Memories.jpg", // Add the image URL
      songArtist: "Maroon 5",
      songCategory: "English Songs",
      songYear: "2019",
      isFav: false, // Initialize isFav to false
    ),
  ];

  List<SongModel> shuffledSongsList = [];

  int selectedIndex = 0;

  TextStyle selectedLabelStyle = customTextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: const Color.fromRGBO(230, 154, 21, 1),
  );

  TextStyle unselectedLabelStyle = customTextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: const Color.fromRGBO(157, 178, 208, 1),
  );

  final List<BottomNavigationBarItem> bottomNavBarItems =
      const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: "Search",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_outline_outlined),
      label: "Favorite",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.playlist_play_rounded),
      label: "Library",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people_rounded),
      label: "Profile",
    ),
  ];

  void onTapItem(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    shuffledSongsList = [...songsList];
    shuffledSongsList.shuffle(Random());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(19, 19, 19, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/2.png",
              height: 400,
              width: 450,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 10),
              child: Row(
                children: [
                  Text(
                    "Recommended",
                    style: customTextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: const Color.fromRGBO(255, 46, 0, 1)),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              // width: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: songsList.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return PlayScreen(
                                startIndex: index, songsList: songsList);
                          },
                        ));
                      },
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              songsList[index].songImg,
                              height: 140,
                              width: 110,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            songsList[index].songName,
                            style: customTextStyle(
                                fontSize: 12,
                                color: const Color.fromRGBO(203, 200, 200, 1)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 10),
              child: Row(
                children: [
                  Text(
                    "Popular Singles",
                    style: customTextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: const Color.fromRGBO(255, 46, 0, 1)),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: shuffledSongsList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PlayScreen(
                            startIndex: index,
                            songsList: shuffledSongsList,
                          ),
                        ));
                      },
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              shuffledSongsList[index].songImg,
                              height: 72,
                              width: 67,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 20),
                            height: 50,
                            width: 250,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  shuffledSongsList[index].songName,
                                  style: customTextStyle(
                                      color: const Color.fromRGBO(
                                          203, 200, 200, 1)),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      shuffledSongsList[index].songYear,
                                      style: customTextStyle(
                                          fontSize: 10,
                                          color: const Color.fromRGBO(
                                              132, 125, 125, 1)),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SvgPicture.asset("assets/star.svg"),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                              child: SvgPicture.asset(
                            "assets/play.svg",
                            height: 30,
                          ))
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(19, 19, 19, 1),
        items: bottomNavBarItems,
        currentIndex: selectedIndex,
        selectedItemColor: const Color.fromRGBO(230, 154, 21, 1),
        unselectedItemColor: const Color.fromRGBO(157, 178, 208, 1),
        onTap: onTapItem,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: selectedLabelStyle,
        unselectedLabelStyle: unselectedLabelStyle,
      ),
    );
  }
}
