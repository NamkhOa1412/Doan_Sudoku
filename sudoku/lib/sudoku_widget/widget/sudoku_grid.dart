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
        return SudokuCell(
          value: grid[row][col],
          isEditable: editableCells[row][col],
          onChanged: (newValue) {
            grid[row][col] = newValue;
          },
        );
      },
      itemCount: 81,
    );
  }
}
