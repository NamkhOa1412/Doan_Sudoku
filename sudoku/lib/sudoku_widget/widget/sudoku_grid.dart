import 'package:flutter/material.dart';
import 'sudoku_cell.dart';

class SudokuGrid extends StatelessWidget {
  final List<List<int>> grid;
  final List<List<bool>> editableCells;

  SudokuGrid({required this.grid, required this.editableCells});

  @override
  Widget build(BuildContext context) {
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
          child: SudokuCell(
            value: grid[row][col],
            isEditable: editableCells[row][col],
            onChanged: (newValue) {
              grid[row][col] = newValue;
            },
          ),
        );
      },
      itemCount: 81,
    );
  }
}
