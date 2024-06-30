import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sudoku/Sudoku_provider.dart/CreateSudokuStart.dart';
import 'package:sudoku/Sudoku_provider.dart/Provider.dart';
import 'package:sudoku/Untils/custom-text.dart';
import 'package:sudoku/sudoku_trangchu/screen_Stargame.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  CustomAppBar({required this.title, required this.actions});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.green.shade700,
                  Colors.green.shade900,
            ])),
      ),
      elevation: 0,
      title: CustomText(
        text: title,
        textColor: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 24,
          ),
          onPressed: () {
            // Navigator.of(context).pop();
            // Provider.of<SudokuStart>(context, listen: false).saveGameState();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (_) => SudokuStart()),
                  ChangeNotifierProvider(create: (_) => SudokuColorProvider()),
                ],
                child: trangchu_Screen(),
              )),
            );
          }),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
