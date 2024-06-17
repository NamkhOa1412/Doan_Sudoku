import 'dart:math';

import 'package:flutter/cupertino.dart';

class SudokuStart extends ChangeNotifier{
  // Tạo bảng Sudoku 9x9 trống
  List<List<int>> _board = List.generate(9, (_) => List.filled(9, 0));

  // Kiểm tra xem một số có thể đặt tại vị trí (row, col) hay không
  bool _canPlace(int num, int row, int col) {
    for (int i = 0; i < 9; i++) {
      if (_board[row][i] == num || _board[i][col] == num) return false;
    }

    int startRow = row - row % 3;
    int startCol = col - col % 3;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[startRow + i][startCol + j] == num) return false;
      }
    }

    return true;
  }

  // Khởi tạo mảng Sudoku đầy đủ
  bool _fillBoard(int row, int col) {
    if (row == 8 && col == 9) return true;

    if (col == 9) {
      row++;
      col = 0;
    }

    for (int num = 1; num <= 9; num++) {
      if (_canPlace(num, row, col)) {
        _board[row][col] = num;
        if (_fillBoard(row, col + 1)) return true;
        _board[row][col] = 0;
      }
    }

    return false;
  }

  // Hàm để khởi tạo mảng Sudoku
  List<List<int>> generateSudoku() {
    _fillBoard(0, 0);
    return _board;
  }

  void _removeDigits(List<List<int>> board, int numToRemove) {
    Random random = Random();
    while (numToRemove > 0) {
      int row = random.nextInt(9);
      int col = random.nextInt(9);

      if (board[row][col] != 0) {
        board[row][col] = 0;
        numToRemove--;
      }
    }
  }

  // Tạo mảng ban đầu cho game Sudoku
  List<List<int>> createSudokuPuzzle(int numToRemove) {
    print(123);
    SudokuStart generator = SudokuStart();
    List<List<int>> board = generator.generateSudoku();
    _removeDigits(board, numToRemove);
    return board; 
  }

  // In mảng Sudoku xuống dòng
  void printBoard(List<List<int>> board) {
    debugPrint("mang");
    for (var row in board) {
      debugPrint(row.toString());
    }
  }
}