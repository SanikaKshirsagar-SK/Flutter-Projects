class SongModel {
  final String songName;
  final String songUrl;
  final String songImg;
  final String songArtist;
  final String songCategory;
  final String songYear;
  bool isFav;

  SongModel({
    required this.songName,
    required this.songUrl,
    required this.songImg,
    required this.songArtist,
    required this.songCategory,
    required this.songYear,
    this.isFav = false,
  });
}
