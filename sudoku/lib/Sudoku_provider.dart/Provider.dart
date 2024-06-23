import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SudokuColorProvider extends ChangeNotifier {
  late List<List<Color>> cellColors;

  SudokuColorProvider() {
    cellColors = List.generate(9, (_) => List.generate(9, (_) => Colors.white));
  }

  void ChangeColor(int row, int col) {
    // setState(() {
      // đặt lại mặt định màu ô
      for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {
          cellColors[i][j] = Colors.white;
        }
      }

      // dổi màu cột và dòng chứa ô hover
      for (int i = 0; i < 9; i++) {
        cellColors[row][i] = Colors.grey.shade400;
        cellColors[i][col] = Colors.grey.shade400;
      }

      // đổi màu vùng 3x3 chứa ô hover
      int startRow = (row ~/ 3) * 3;
      int startCol = (col ~/ 3) * 3;
      for (int i = startRow; i < startRow + 3; i++) {
        for (int j = startCol; j < startCol + 3; j++) {
          cellColors[i][j] = Colors.grey.shade400;
        }
      }
      cellColors[row][col] = Colors.green;

      notifyListeners();
    // });
  }
}