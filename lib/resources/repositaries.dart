import 'package:music_system/models/track_model.dart';

import 'package:music_system/dao/saved_dao.dart';
import 'package:music_system/models/saved.dart';

import 'listview_api.dart';
import 'package:music_system/models/list_model.dart';
import 'lyrics_api.dart';

class Repositary {
  final listviewapi = ListViewAPI();
  Future<ListModel> fetchAllList() => listviewapi.fetchdata();
}

class Repositaries {
  var lyricsapi = LyricsAPI();

  Future<LyricsModel> fetchAllList(int trackID) => lyricsapi.fetchdata(trackID);
}

// class Connectivit {
//   Map _source = {ConnectivityResult.none: false};
//   MyConnectivity _connectivity = MyConnectivity.instance;
//   Future<Map> fetchConnection() async {
//     _connectivity.initialise();
//     _connectivity.myStream.listen((source) {
//       _source = source;
//     });
//     return _source;
//   }
// }

class SavedRepository {
  final savedDao = SavedDao();

  Future getAllSaved() => savedDao.getSaves();

  Future insertSaved(Saved saved) => savedDao.createSaved(saved);

  Future deleteSavedById(int trackID) => savedDao.deleteSaved(trackID);
}
