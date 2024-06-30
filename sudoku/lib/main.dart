import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/Sudoku_provider.dart/CreateSudokuStart.dart';
import 'package:sudoku/Sudoku_provider.dart/Provider.dart';
import 'package:sudoku/sudoku_trangchu/screen_Stargame.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      home: trangchu_Screen(),
      // home: MultiProvider(
      //   providers: [
      //     ChangeNotifierProvider(create: (_) => SudokuStart()),
      //     ChangeNotifierProvider(create: (_) => SudokuColorProvider()),
      //   ],
      //   child: trangchu_Screen(),
      //   ),
    );
  }
}
