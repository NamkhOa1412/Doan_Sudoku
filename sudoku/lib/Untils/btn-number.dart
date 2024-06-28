import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/Sudoku_provider.dart/CreateSudokuStart.dart';

class Button_Number extends StatelessWidget {
  final double width;
  final double height;
  final int data;
  Button_Number({
    Key? key,
    required this.data,
    required this.width,
    this.height = 70,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //nhập giá trị lên ma trận
        Provider.of<SudokuStart>(context, listen: false).placeNumber(data,context);
      },
      child: Container(
        width: width / 12,
        height: height,
        decoration: BoxDecoration(
            color: Colors.green.shade700,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ]),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$data",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}
