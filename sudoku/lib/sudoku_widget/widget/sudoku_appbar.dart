import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudoku/Untils/custom-text.dart';

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
                  Colors.white,
                  Colors.white,
            ])),
      ),
      elevation: 0,
      title: CustomText(
        text: title,
        textColor: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 24,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
