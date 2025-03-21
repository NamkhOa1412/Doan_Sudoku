import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sudoku/Sudoku_provider.dart/CreateSudokuStart.dart';
import 'package:sudoku/Untils/custom-text.dart';

class Info_sudoku_play extends StatefulWidget {
  Info_sudoku_play({ Key? key}) : super(key: key);

  @override
  State<Info_sudoku_play> createState() => _Info_sudoku_playState();
}

class _Info_sudoku_playState extends State<Info_sudoku_play> {
  // @override
  // void initState() {
  //   super.initState();
  //   loadData();
  // }

  // Future<void> loadData() async {
  //   await Provider.of<SudokuStart>(context, listen: false).loadGameState();
  //   setState(() {}); // Update the state to reflect the loaded data
  // }
  @override
  Widget build(BuildContext context) {
    final error = context.watch<SudokuStart>().errorpoint;
    final time = context.watch<SudokuStart>().Time();
    final Lever = context.watch<SudokuStart>().lever;
    return Container(
      child: Column(
        children: [
          // Expanded(
          //   //điểm
          //   child: Container(
          //     alignment: Alignment.bottomCenter,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         CustomText(text: "Điểm số: ",fontsize: 17,textColor: Colors.green,),
          //         //truyền điểm
          //         CustomText(text: "0",fontsize: 17,fontWeight: FontWeight.bold,)
          //       ],
          //     ),
          //   )
          // ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      CustomText(text: "Lỗi: ",fontsize: 15),
                      //lỗi có thể đổi
                      CustomText(text: error.toString(),fontsize: 15),
                      CustomText(text: "/3",fontsize: 15,)
                    ],),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      //cấp độ
                      CustomText(text: Lever,fontsize: 15),
                    ],),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                      //thời gian
                      CustomText(text: time.toString(),fontsize: 15),
                    ],),
                  ),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}