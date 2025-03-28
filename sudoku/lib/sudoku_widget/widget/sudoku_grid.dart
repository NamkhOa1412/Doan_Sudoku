import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/Sudoku_provider.dart/CreateSudokuStart.dart';
import 'package:sudoku/Sudoku_provider.dart/Provider.dart';
import 'sudoku_cell.dart';

class SudokuGrid extends StatefulWidget {
  final List<List<int>> grid;
  final String lever;
  final String type;

  SudokuGrid({required this.grid,required this.lever, required this.type});
  @override
  _SudokuGridState createState() => _SudokuGridState();
}

class _SudokuGridState extends State<SudokuGrid> {
  List<List<int>>? sudokuBoard;

  @override
  void initState() {
    super.initState();
    widget.type == "new game" ? sudokuBoard = Provider.of<SudokuStart>(context, listen: false).createSudokuPuzzle(widget.lever ,widget.lever == "Dễ" ? 20 : 35) : loadData();
  }

  Future<void> loadData() async {
    sudokuBoard = await Provider.of<SudokuStart>(context, listen: false).loadGameState(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final color = Provider.of<SudokuColorProvider>(context);
    final sudoku = Provider.of<SudokuStart>(context);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 9,
      ),
      itemBuilder: (context, index) {
        int row = index ~/ 9;
        int col = index % 9;
        double topBorder = (row % 3 == 0) ? 2.0 : 0.5;
        double leftBorder = (col % 3 == 0) ? 2.0 : 0.5;
        double rightBorder = (col == 8) ? 2.0 : 0.5;
        double bottomBorder = (row == 8) ? 2.0 : 0.5;
        return Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: topBorder, color: Colors.black),
              left: BorderSide(width: leftBorder, color: Colors.black),
              right: BorderSide(width: rightBorder, color: Colors.black),
              bottom: BorderSide(width: bottomBorder, color: Colors.black),
            ),
          ),
          child:
          SudokuCell(
            row: row,
            col: col,
            value: sudokuBoard![row][col],
            cellColor: color.cellColors[row][col],
            onChanged: (newValue) {
              widget.grid[row][col] = newValue;
            },
            onTap: () {
             color.ChangeColor(row, col);
             sudoku.selectCell(row, col);
            },
          ),
        );
      },
      itemCount: 81,
    );
  }
}