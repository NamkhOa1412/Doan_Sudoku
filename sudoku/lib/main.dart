import 'package:flutter/material.dart';
import 'package:sudoku/sudoku_trangchu/screen_Stargame.dart';
import 'package:sudoku/sudoku_widget/sudoku_play_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Sudoku_Screen()
      home: trangchu_Screen()
    );
  }
}
