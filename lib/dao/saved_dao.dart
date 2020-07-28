import 'dart:async';
import 'package:music_system/models/saved.dart';
import 'package:music_system/resources/database.dart';

class SavedDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createSaved(Saved saved) async {
    final db = await dbProvider.database;
    var result = db.insert(savedTABLE, saved.toDatabaseJson());
    return result;
  }

  Future<List<Saved>> getSaves() async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    result = await db.query(savedTABLE);

    List<Saved> saves = result.isNotEmpty
        ? result.map((item) => Saved.fromDatabaseJson(item)).toList()
        : [];
    return saves;
  }

  Future<bool> isThere(int id) async {
    List<Saved> cur = await getSaves();
    for (var temp in cur) {
      if (temp.trackID == id) return true;
    }
    return false;
  }

  Future<int> deleteSaved(int trackID) async {
    final db = await dbProvider.database;
    var result =
        await db.delete(savedTABLE, where: 'trackID = ?', whereArgs: [trackID]);

    return result;
  }
}
