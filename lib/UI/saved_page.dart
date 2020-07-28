import 'package:flutter/material.dart';
import 'package:music_system/blocs/listview_bloc.dart';
import 'package:music_system/models/saved.dart';

class SavedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.initialise();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0D0F20),
          title: Text('BookMarked Tracks'),
        ),
        body: StreamBuilder(
          stream: bloc.saved,
          builder: (BuildContext context, AsyncSnapshot<List<Saved>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(5),
                    color: Color(0xFF1C1C2D),
                    child: ListTile(
                      trailing: FlatButton(
                        onPressed: () {
                          bloc.deleteSavedById(snapshot.data[index].trackID);
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      title: Text(snapshot.data[index].trackName),
                      subtitle: Text(snapshot.data[index].trackID.toString()),
                    ),
                  );
                },
              );
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
