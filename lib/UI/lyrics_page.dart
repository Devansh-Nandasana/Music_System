import 'package:flutter/material.dart';
import 'package:music_system/models/list_model.dart';
import 'package:music_system/blocs/listview_bloc.dart';
import 'package:music_system/models/saved.dart';
import 'package:music_system/models/track_model.dart';
import 'package:connectivity/connectivity.dart';

class LyricsPage extends StatelessWidget {
  final ListData listData;
  LyricsPage(this.listData);

  @override
  Widget build(BuildContext context) {
    bloc.fetchdata(listData.trackID);
    bloc.fetchconnection();
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Map<String, dynamic> data = {
                "trackID": listData.trackID,
                "trackName": listData.track_name,
              };
              Saved temp = Saved.fromDatabaseJson(data);
              bloc.addSaved(temp);
            },
            child: Icon(
              Icons.bookmark,
            ),
          )
        ],
        title: Text('Lyrics'),
      ),
      body: StreamBuilder(
        stream: bloc.connection,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.keys.toList()[0] == ConnectivityResult.none) {
              return SafeArea(
                  child: Scaffold(
                body: Center(
                  child: Text(
                    'Please Connect to Internet',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Black ops',
                    ),
                  ),
                ),
              ));
            } else {
              bloc.fetchdata(listData.trackID);
              return StreamBuilder(
                stream: bloc.data,
                builder: (context, AsyncSnapshot<LyricsModel> snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Track Name:',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'Rowdies',
                              ),
                            ),
                            Text(
                              snapshot.data.track_name,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Artist Name:',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'Rowdies',
                              ),
                            ),
                            Text(
                              snapshot.data.artist_name,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Album Name:',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'Rowdies',
                              ),
                            ),
                            Text(
                              snapshot.data.album_name,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Explicit:',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'Rowdies',
                              ),
                            ),
                            Text(
                              snapshot.data.explicit == 0 ? 'false' : 'true',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Restrict:',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'Rowdies',
                              ),
                            ),
                            Text(
                              snapshot.data.restrict == 0 ? 'false' : 'true',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Lyrics:',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: 'Rowdies',
                              ),
                            ),
                            Text(
                              snapshot.data.lyrics,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                },
              );
            }
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
