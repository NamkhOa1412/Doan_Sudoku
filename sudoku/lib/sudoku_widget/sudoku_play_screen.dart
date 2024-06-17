import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/Sudoku_provider.dart/CreateSudokuStart.dart';
import 'package:sudoku/Sudoku_provider.dart/Provider.dart';
import 'package:sudoku/Untils/btn-number.dart';
import 'package:sudoku/sudoku_widget/widget/info.dart';
import 'package:sudoku/sudoku_widget/widget/sudoku_appbar.dart';
import 'package:sudoku/sudoku_widget/widget/sudoku_function.dart';
import 'package:sudoku/sudoku_widget/widget/sudoku_grid.dart';

class Sudoku_Screen extends StatefulWidget {
  String lever;
  Sudoku_Screen({ Key? key , required this.lever}) : super(key: key);

  @override
  State<Sudoku_Screen> createState() => _Sudoku_ScreenState();
}

class _Sudoku_ScreenState extends State<Sudoku_Screen> {
   List<List<int>> grid = List.generate(9, (index) => List.generate(9, (index) => 0));
  List<List<bool>> editableCells = List.generate(9, (index) => List.generate(9, (index) => false));

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print(widget.lever);
    return Scaffold(
      appBar: CustomAppBar(
        title: "Sudoku", 
        actions: [],
      ),
      body: Column(
        children: [
          //Điểm số, cấp độ, số lần lỗi và thờ gian
          Expanded(
            flex: 1, 
            child: Info_sudoku_play(lever: widget.lever)
          ),
          Expanded(
            flex: 6,
            child: Container(
              child: Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child:  MultiProvider(
                    providers: [
                      ChangeNotifierProvider(create: (_) => SudokuStart()),
                      ChangeNotifierProvider(create: (_) => SudokuColorProvider()),
                    ],
                    child:  SudokuGrid(
                      grid: grid,
                      editableCells: editableCells,
                    ),
                  ),
                ),
              ),
                  ),
            ),
          ),
          //chức năng
          Expanded(
            flex: 1, 
            child: Sudoku_Func()
          ),
          //các widget số
          Expanded(
            flex: 2, 
            child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(9, (index) {
                      return Button_Number(data: index + 1, width: width,);
                    })
            ),
                ],
              )
          )
        ],
      )
    );
  }
}