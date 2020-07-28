class LyricsModel {
  // ignore: non_constant_identifier_names
  String _track_name;
  int _trackRating;
  int _explicit;
  int _restrict;
  // ignore: non_constant_identifier_names
  String _album_name;
  // ignore: non_constant_identifier_names
  String _artist_name;
  String lyricss;
  LyricsModel.first(data) {
    _restrict = data['message']['body']['track']['restricted'];
    _explicit = data['message']['body']['track']['explicit'];
    _trackRating = data['message']['body']['track']['track_rating'];
    _track_name = data['message']['body']['track']['track_name'];
    _album_name = data['message']['body']['track']['album_name'];
    _artist_name = data['message']['body']['track']['artist_name'];
  }
  LyricsModel.second(data) {
    lyricss = data['message']['body']['lyrics']['lyrics_body'];
  }
  String get lyrics => lyricss;
  int get restrict => _restrict;
  int get explicit => _explicit;
  int get trackRating => _trackRating;
  // ignore: non_constant_identifier_names
  String get track_name => _track_name;
  // ignore: non_constant_identifier_names
  String get album_name => _album_name;
  // ignore: non_constant_identifier_names
  String get artist_name => _artist_name;
}
