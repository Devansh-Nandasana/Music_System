class Saved {
  int trackID;
  String trackName;
  bool isSaved = false;
  Saved({this.trackID, this.trackName, this.isSaved = false});
  factory Saved.fromDatabaseJson(Map<String, dynamic> data) => Saved(
        trackID: data['trackID'],
        trackName: data['trackName'],
        isSaved: data['is_saved'] == 0 ? false : true,
      );
  Map<String, dynamic> toDatabaseJson() => {
        "trackID": this.trackID,
        "trackName": this.trackName,
        "is_saved": this.isSaved == false ? 0 : 1,
      };
}
