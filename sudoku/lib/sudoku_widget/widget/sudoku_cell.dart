import 'package:flutter/material.dart';

class SudokuCell extends StatelessWidget {
  final int value;
  final bool isEditable;
  final Function(int) onChanged;

  SudokuCell({required this.value, required this.isEditable, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: isEditable
          // ? TextField(
          //     textAlign: TextAlign.center,
          //     keyboardType: TextInputType.number,
          //     onChanged: (val) {
          //       if (val.isNotEmpty) {
          //         onChanged(int.parse(val));
          //       }
          //     },
          //   )
          ? Container()
          : Center(
              child: Text(
                value != 0 ? value.toString() : '',
                style: TextStyle(fontSize: 20),
              ),
            ),
    );
  }
}
