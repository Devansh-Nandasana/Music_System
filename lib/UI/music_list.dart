import 'package:flutter/material.dart';
import 'package:music_system/UI/saved_page.dart';
import 'package:music_system/blocs/listview_bloc.dart';
import 'package:music_system/models/list_model.dart';
import 'lyrics_page.dart';
import 'package:connectivity/connectivity.dart';

class MusicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.fetchlist();
    bloc.initialise();
    bloc.fetchconnection();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0D0F20),
          title: Center(child: Text('Music System')),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SavedPage();
                }));
              },
              child: Icon(
                Icons.bookmark,
                color: Colors.red,
              ),
            )
          ],
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
                bloc.fetchlist();
                return StreamBuilder(
                  stream: bloc.lists,
                  builder: (context, AsyncSnapshot<ListModel> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        padding: EdgeInsets.all(8.0),
                        itemCount: snapshot.data.list_model.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.all(5),
                            color: Color(0xFF1C1C2D),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return LyricsPage(
                                      snapshot.data.list_model[index]);
                                }));
                              },
                              leading: Icon(
                                Icons.library_music,
                                size: 30.0,
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    snapshot.data.list_model[index].track_name,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'Rowdies',
                                    ),
                                  ),
                                  Text(
                                      'from ${snapshot.data.list_model[index].album_name}'),
                                  Text(
                                      'by ${snapshot.data.list_model[index].artist_name}'),
                                ],
                              ),
                            ),
                          );
                        },
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
      ),
    );
  }
}
