import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:music_system/models/saved.dart';
import 'package:rxdart/rxdart.dart';
import 'package:music_system/resources/repositaries.dart';
import 'package:music_system/models/list_model.dart';
import 'package:music_system/models/track_model.dart';
import 'package:music_system/resources/connectivities.dart';

class ListViewBloc {
  final _repositary = Repositary();
  final _listFetcher = PublishSubject<ListModel>();
  Stream<ListModel> get lists => _listFetcher.stream;

  fetchlist() async {
    ListModel listModel = await _repositary.fetchAllList();
    _listFetcher.sink.add(listModel);
  }

  final _repositaries = Repositaries();
  // ignore: close_sinks
  final _dataFetcher = PublishSubject<LyricsModel>();
  Stream<LyricsModel> get data => _dataFetcher.stream;

  fetchdata(int trackID) async {
    LyricsModel lyricsModel = await _repositaries.fetchAllList(trackID);
    _dataFetcher.sink.add(lyricsModel);
  }

  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;
  final _connectionFetcher = PublishSubject<Map>();
  Stream<Map> get connection => _connectionFetcher.stream;

  fetchconnection() async {
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      _source = source;
      _connectionFetcher.sink.add(_source);
    });
  }

  final _savedRepository = SavedRepository();

  final _savedController = StreamController<List<Saved>>.broadcast();

  get saved => _savedController.stream;

  initialise() {
    getSaved();
  }

  getSaved() async {
    _savedController.sink.add(await _savedRepository.getAllSaved());
  }

  addSaved(Saved saved) async {
    await _savedRepository.insertSaved(saved);
    getSaved();
  }

  deleteSavedById(int id) async {
    _savedRepository.deleteSavedById(id);
    getSaved();
  }

  dispose() {
    _connectionFetcher.close();
    _listFetcher.close();
    _listFetcher.close();
    _savedController.close();
  }
}

final bloc = ListViewBloc();
