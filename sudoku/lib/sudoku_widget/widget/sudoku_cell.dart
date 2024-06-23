import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/Sudoku_provider.dart/CreateSudokuStart.dart';

class SudokuCell extends StatefulWidget {
  final int row;
  final int col;
  final int value;
  final bool isEditable;
  final Function(int) onChanged;
  final Color cellColor;
  final VoidCallback onTap;

  SudokuCell({
    required this.row,
    required this.col,
    required this.value,
    required this.isEditable,
    required this.onChanged,
    required this.cellColor,
    required this.onTap,
  });

  @override
  _SudokuCellState createState() => _SudokuCellState();
}



class _SudokuCellState extends State<SudokuCell> {
  @override
  Widget build(BuildContext context) {
    final sudokuStart = Provider.of<SudokuStart>(context, listen: false);
    bool isEditable = sudokuStart.editableCells[widget.row][widget.col];
    bool isCellCorrect = sudokuStart.check_Cell(widget.row, widget.col);
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: widget.cellColor,
          border: Border.all(color: Colors.grey),
        ),
        child: widget.isEditable
            ? Container()
            : Center(
                child: Text(
                  widget.value != 0 ? widget.value.toString() : '',
                  // widget.value.toString(),
                  style: TextStyle(fontSize: 20,
                  color: isEditable ? (isCellCorrect ? Colors.black : Colors.red) : Colors.black,
                  ),
                ),
              ),
      ),
    );
  }
}
