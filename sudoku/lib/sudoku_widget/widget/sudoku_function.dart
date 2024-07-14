import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/Sudoku_provider.dart/CreateSudokuStart.dart';

class Sudoku_Func extends StatelessWidget {
  const Sudoku_Func({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final check_pencil = context.watch<SudokuStart>().pencil;
    final suggest = context.watch<SudokuStart>().suggest;
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                print("xóa");
                Provider.of<SudokuStart>(context, listen: false).removeNumber();
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
            flex: 3,
            child: GestureDetector(
              onTap: () {
                print("viết chì");
                Provider.of<SudokuStart>(context,listen: false).pencilMode(); 
              },
              child: Stack(
                children : [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/icon/icons8-pencil-20.png"),
                        Text("Viết chì")
                      ],
                    ),
                  ),
                  Positioned(
                    right: 30,
                    child: Text(check_pencil ? "On" : "Off",style: TextStyle(color: check_pencil ? Colors.green : null,fontWeight: FontWeight.bold),)
                  )
                ]
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                Provider.of<SudokuStart>(context,listen: false).suggest_number(context); 
              },
              child: Stack(
                children : [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image.asset("assets/icon/icons8-pencil-20.png"),
                        Icon(Icons.lightbulb_outline_rounded),
                        Text("Gợi ý")
                      ],
                    ),
                  ),
                  Positioned(
                    right: 40,
                    child: Text(suggest.toString(),style: TextStyle(fontWeight: FontWeight.bold),)
                  )
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}