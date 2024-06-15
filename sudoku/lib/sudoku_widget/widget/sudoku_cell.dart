import 'package:flutter/material.dart';

class SudokuCell extends StatefulWidget {
  final int value;
  final bool isEditable;
  final Function(int) onChanged;
  final Color cellColor;
  final VoidCallback onTap;

  SudokuCell({
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
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: widget.cellColor,
          border: Border.all(color: Colors.grey),
        ),
        child: widget.isEditable
            // ? TextField(
            //     textAlign: TextAlign.center,
            //     keyboardType: TextInputType.number,
            //     onChanged: (val) {
            //       if (val.isNotEmpty) {
            //         widget.onChanged(int.parse(val));
            //       }
            //     },
            //   )
            ? Container()
            : Center(
                child: Text(
                  widget.value != 0 ? widget.value.toString() : '',
                  style: TextStyle(fontSize: 20),
                ),
              ),
      ),
    );
  }
}
