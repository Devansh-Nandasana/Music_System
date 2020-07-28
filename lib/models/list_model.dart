class ListModel {
  // ignore: non_constant_identifier_names
  List<ListData> _list_model = [];
  ListModel(var data) {
    for (int i = 0; i < 10; i++) {
      _list_model.add(ListData(data, i));
    }
  }
  // ignore: non_constant_identifier_names
  List<ListData> get list_model => _list_model;
}

class ListData {
  // ignore: non_constant_identifier_names
  String _track_name;
  int _trackID;
  int _trackRating;
  int _explicit;
  int _restrict;
  // ignore: non_constant_identifier_names
  String _album_name;
  // ignore: non_constant_identifier_names
  String _artist_name;

  ListData(data, int index) {
    _restrict =
        data['message']['body']['track_list'][index]['track']['restricted'];
    _explicit =
        data['message']['body']['track_list'][index]['track']['explicit'];
    _trackRating =
        data['message']['body']['track_list'][index]['track']['track_rating'];
    _trackID =
        data['message']['body']['track_list'][index]['track']['track_id'];
    _track_name =
        data['message']['body']['track_list'][index]['track']['track_name'];
    _album_name =
        data['message']['body']['track_list'][index]['track']['album_name'];
    _artist_name =
        data['message']['body']['track_list'][index]['track']['artist_name'];
  }
  int get restrict => _restrict;
  int get explicit => _explicit;
  int get trackRating => _trackRating;
  int get trackID => _trackID;
  // ignore: non_constant_identifier_names
  String get track_name => _track_name;
  // ignore: non_constant_identifier_names
  String get album_name => _album_name;
  // ignore: non_constant_identifier_names
  String get artist_name => _artist_name;
}
