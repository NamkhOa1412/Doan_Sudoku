import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SudokuStart extends ChangeNotifier{
  // Tạo bảng Sudoku 9x9 trống
  List<List<int>> _board = List.generate(9, (_) => List.filled(9, 0));
  List<List<bool>> editableCells = List.generate(9, (_) => List.filled(9, true));
  List<List<int>> boardcur =[];
   List<List<int>> _fullBoard = [];
  List<List<int>> board_result =[];
  int? _selectedRow;
  int? _selectedCol;
  List<List<bool>> checkCell = List.generate(9, (_) => List.filled(9, true));


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
    
    List<int> numbers = List.generate(9, (index) => index + 1);
    if (row == 0) {
      numbers.shuffle();
    }

    for (int num in numbers) {
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
    List<List<int>> _deepCopyBoard(List<List<int>> board) {
    return board.map((row) => List<int>.from(row)).toList();
  }


  // Tạo mảng ban đầu cho game Sudoku
  List<List<int>> createSudokuPuzzle(int numToRemove) {
     _board = List.generate(9, (_) => List.filled(9, 0));
    generateSudoku();
    _fullBoard = _deepCopyBoard(_board);

    print(_fullBoard);

    _removeDigits(_board, numToRemove);


    boardcur = _board;
    return _board;
  }

  // Đặt số tại vị trí ô đã chọn
  void placeNumber(int number) {
    try {
     
      if (_selectedRow != null && _selectedCol != null && editableCells[_selectedRow!][_selectedCol!]) {
        if(boardcur[_selectedRow!][_selectedCol!] == 0 ) {
          if(_fullBoard[_selectedRow!][_selectedCol!] == number) {
            print("xanh");
            boardcur[_selectedRow!][_selectedCol!] = number; 
            checkCell[_selectedRow!][_selectedCol!] = true;
          }
          else {
            print("đỏ");
            boardcur[_selectedRow!][_selectedCol!] = number; 
            checkCell[_selectedRow!][_selectedCol!] = false;
          }
          // boardcur[selectedRow!][selectedCol!] = number; 

          notifyListeners();
        }
        else { print("lỗi"); }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void selectCell(int row, int col) {
    try {
      if (editableCells[row][col]) {
        _selectedRow = row;
        _selectedCol = col;
        notifyListeners();
      }
    } catch (e) {
      print("Error: $e");
    }
  }
  bool check_Cell(int row, int col) => checkCell[row][col]; 
}