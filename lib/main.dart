import 'package:flutter/material.dart';
import 'UI/music_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0D0F20),
        scaffoldBackgroundColor: Color(0xFF0D0F20),
      ),
      title: 'Internship Project',
      home: MusicList(),
    );
  }
}
