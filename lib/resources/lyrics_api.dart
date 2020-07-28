import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_system/models/track_model.dart';

class LyricsAPI {
  final String _apikey = 'ac87f68422c3c36f4f8667c85674f1b4';

  Future<LyricsModel> fetchdata(int trackID) async {
    var response = await http.get(
        'https://api.musixmatch.com/ws/1.1/track.get?track_id=$trackID&apikey=$_apikey');
    String data = response.body;
    LyricsModel temp = LyricsModel.first(jsonDecode(data));

    response = await http.get(
        'https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackID&apikey=$_apikey');
    data = response.body;
    LyricsModel temp1 = LyricsModel.second(jsonDecode(data));
    temp.lyricss = temp1.lyricss;
    // print(temp.artist_name);
    // print(temp.lyrics);
    return temp;
  }
}
