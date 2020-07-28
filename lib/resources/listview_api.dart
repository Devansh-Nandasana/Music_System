import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_system/models/list_model.dart';

class ListViewAPI {
  final String _apikey = 'ac87f68422c3c36f4f8667c85674f1b4';
  Future<ListModel> fetchdata() async {
    final response = await http.get(
        'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=$_apikey');
    String data = response.body;
    return ListModel(jsonDecode(data));
  }
}
