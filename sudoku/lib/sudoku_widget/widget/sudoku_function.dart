import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sudoku_Func extends StatelessWidget {
  const Sudoku_Func({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: GestureDetector(
              onTap: () {
                print("xóa");
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icon/icons8-eraser-20.png"),
                  Text("Xóa")
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: GestureDetector(
              onTap: () {
                print("viết chì");
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icon/icons8-pencil-20.png"),
                  Text("Viết chì")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}