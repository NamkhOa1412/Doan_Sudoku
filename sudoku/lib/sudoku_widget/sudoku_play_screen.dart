import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudoku/Untils/btn-number.dart';
import 'package:sudoku/sudoku_widget/widget/info.dart';
import 'package:sudoku/sudoku_widget/widget/sudoku_appbar.dart';
import 'package:sudoku/sudoku_widget/widget/sudoku_function.dart';
import 'package:sudoku/sudoku_widget/widget/sudoku_grid.dart';

class Sudoku_Screen extends StatefulWidget {
  const Sudoku_Screen({ Key? key }) : super(key: key);

  @override
  State<Sudoku_Screen> createState() => _Sudoku_ScreenState();
}

class _Sudoku_ScreenState extends State<Sudoku_Screen> {
   List<List<int>> grid = List.generate(9, (index) => List.generate(9, (index) => 0));
  List<List<bool>> editableCells = List.generate(9, (index) => List.generate(9, (index) => true));

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
            child: Info_sudoku_play()
          ),
          Expanded(
            flex: 6,
            child: Container(
              child: Padding(
              padding: EdgeInsets.all(10),
              child: Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: SudokuGrid(
                    grid: grid,
                    editableCells: editableCells,
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