import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../model/song_model.dart';
import '../widgets/style_widget.dart';

class PlayScreen extends StatefulWidget {
  final List<SongModel> songsList;
  final int startIndex;

  const PlayScreen({
    super.key,
    required this.songsList,
    required this.startIndex,
  });

  @override
  State<PlayScreen> createState() => PlayScreenState();
}

class PlayScreenState extends State<PlayScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isSongLoaded = false;
  bool isCurrentSongPlaying = false;
  int currentIndex = 0;
  double progress = 0.01;
  Duration? pausePosition;
  String currentTime = "00:00";
  String totalTime = "00:00";

  @override
  void initState() {
    super.initState();
    currentIndex = widget.startIndex;
    playSong();
    audioPlayer.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          currentTime =
              "${position.inMinutes.remainder(60).toString().padLeft(2, "0")}:${position.inSeconds.remainder(60).toString().padLeft(2, "0")}";
          log("Current T $currentTime");
        });
      }
    });

    audioPlayer.durationStream.listen((duration) {
      if (mounted) {
        setState(() {
          totalTime =
              "${duration!.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}";
          log("Total T $totalTime");
        });
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playSong() async {
    if (isPlaying) {
      return;
    }
    await audioPlayer.stop();
    if (mounted) {
      setState(() {
        currentIndex = widget.startIndex;
        isPlaying = true;
        isSongLoaded = true;
        progress = 0;
      });
    }
    if (mounted) {
      setState(() {
        isCurrentSongPlaying = true;
      });
    }
    await audioPlayer
        .setAsset("assets/audio/${widget.songsList[currentIndex].songUrl}");
    if (pausePosition != null) {
      await audioPlayer.seek(pausePosition);
      pausePosition = null;
    }
    await audioPlayer.play();
    audioPlayer.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          if (audioPlayer.duration != null) {
            progress =
                position.inMilliseconds / audioPlayer.duration!.inMilliseconds;
          } else {
            progress = 0;
          }
        });
      }
    });
    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        nextSong();
      }
    });
  }

  void nextSong() async {
    if (currentIndex < widget.songsList.length - 1) {
      currentIndex++;
    } else {
      currentIndex = 0;
    }
    pausePosition = null;
    await audioPlayer.stop();
    await audioPlayer
        .setAsset("assets/audio/${widget.songsList[currentIndex].songUrl}");
    setState(() {
      isCurrentSongPlaying = true;
    });
    await audioPlayer.play();
  }

  void previousSong() async {
    if (currentIndex > 0) {
      currentIndex--;
    } else {
      currentIndex = widget.songsList.length - 1;
    }
    pausePosition = null;
    await audioPlayer.stop();
    await audioPlayer
        .setAsset("assets/audio/${widget.songsList[currentIndex].songUrl}");
    setState(() {
      isCurrentSongPlaying = true;
    });
    await audioPlayer.play();
  }

  Future<void> pauseSong() async {
    if (isCurrentSongPlaying) {
      await audioPlayer.pause();
      setState(() {
        isCurrentSongPlaying = false;
      });
    }
  }

  Future<void> resumeSong() async {
    if (!isCurrentSongPlaying) {
      await audioPlayer.play();
      setState(() {
        isCurrentSongPlaying = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(19, 19, 19, 1),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Image.asset(
              widget.songsList[currentIndex].songImg,
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.songsList[currentIndex].songName,
                            style: customTextStyle(
                                fontSize: 20, fontWeight: FontWeight.w900)),
                        Text(widget.songsList[currentIndex].songArtist,
                            style: customTextStyle(
                              color: const Color.fromRGBO(217, 217, 200, 1),
                            )),
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.favorite_border_outlined,
                      size: 30,
                      color: Color.fromRGBO(217, 217, 200, 1),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Column(children: [
                GestureDetector(
                  onTap: () async {
                    await audioPlayer.seek(Duration(
                        milliseconds:
                            (progress * audioPlayer.duration!.inMilliseconds)
                                .toInt()));
                  },
                  onHorizontalDragUpdate: (details) async {
                    double newVal = (progress + (details.delta.dx / 370));
                    if (newVal < 0) {
                      newVal = 0;
                    } else if (newVal > 1) {
                      newVal = 1;
                    }
                    setState(() {
                      progress = newVal;
                    });
                    await audioPlayer.seek(Duration(
                        milliseconds:
                            (newVal * audioPlayer.duration!.inMilliseconds)
                                .toInt()));
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: LinearPercentIndicator(
                          lineHeight: 8.0,
                          percent: isSongLoaded
                              ? progress
                              : audioPlayer.duration != null
                                  ? audioPlayer.position.inMilliseconds /
                                      audioPlayer.duration!.inMilliseconds
                                  : 0,
                          barRadius: const Radius.circular(15),
                          progressColor: const Color.fromRGBO(230, 154, 21, 1),
                          backgroundColor:
                              const Color.fromRGBO(217, 217, 217, 0.19),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13),
                  child: Row(
                    children: [
                      Text(
                        currentTime,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Spacer(),
                      Text(totalTime,
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: previousSong,
                    child: SvgPicture.asset("assets/prev.svg", height: 50),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (isCurrentSongPlaying) {
                        await pauseSong();
                      } else {
                        await resumeSong();
                      }
                    },
                    child: SvgPicture.asset(
                      isCurrentSongPlaying
                          ? "assets/pause.svg"
                          : "assets/play.svg",
                      height: 50,
                    ),
                  ),
                  GestureDetector(
                    onTap: nextSong,
                    child: SvgPicture.asset("assets/next.svg", height: 50),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
