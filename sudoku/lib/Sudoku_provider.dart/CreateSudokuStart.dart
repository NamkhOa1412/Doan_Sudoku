import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/Untils/custom-text.dart';
import 'package:sudoku/sudoku_trangchu/cls_DiemSo.dart';
import 'package:sudoku/sudoku_trangchu/screen_Stargame.dart';
import 'package:sudoku/sudoku_widget/sudoku_play_screen.dart';

class SudokuStart extends ChangeNotifier{
  // Tạo bảng Sudoku 9x9 trống
  List<List<int>> board = List.generate(9, (_) => List.filled(9, 0));
  List<List<bool>> editableCells = List.generate(9, (_) => List.filled(9, true));
  List<List<int>> boardcur =[];
  List<List<int>> _fullBoard = [];
  List<List<int>> board_result =[];
  int? selectedRow;
  int? selectedCol;
  int errorpoint = 0;
  List<List<bool>> checkCell = List.generate(9, (_) => List.filled(9, true));
  Timer? timer;
  DateTime? StartTime;
  int Minutes = 0;
  int Seconds = 0;
  String lever= "";
  bool pencil = false;
  List<List<Set<int>>> pencilboard = List.generate(9, (_) => List.generate(9, (_) => <int>{}));
  int suggest = 3;

  
  @override
  void dispose() {
    stopTime();
    // TODO: implement dispose
    saveGameState();
    super.dispose();
  }

  void pencilMode() {
    pencil = !pencil;
    print(pencil);
    notifyListeners();
  }

  void suggest_number (context) {
    if (suggest > 0) {
      if (selectedRow != null && selectedCol != null && editableCells[selectedRow!][selectedCol!]) {
        if (boardcur[selectedRow!][selectedCol!] != 0 && checkCell[selectedRow!][selectedCol!] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: CustomText(text: "Chọn ô trống để sử dụng chức năng", textColor: Colors.white)));
        }
        else {
          boardcur[selectedRow!][selectedCol!] = _fullBoard[selectedRow!][selectedCol!]; 
          checkCell[selectedRow!][selectedCol!] = true;
          suggest--;
          if (completeSudoku(boardcur, _fullBoard)){
            DialogComplete(context);
            stopTime();
            saveGameResult();
            print("hoàn thành");
          }
          notifyListeners();
        }
      }else {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: CustomText(text: "Chọn ô trống để sử dụng chức năng", textColor: Colors.white)));
      }
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: CustomText(text: "Bạn đã sử dụng hết 3 lượt gợi ý", textColor: Colors.white)));
    }
  }

  void addPencilBoard(int number) {
    if (selectedRow != null && selectedCol != null && editableCells[selectedRow!][selectedCol!]) {
      if (pencilboard[selectedRow!][selectedCol!].contains(number)) {
        pencilboard[selectedRow!][selectedCol!].remove(number);
      } else {
        pencilboard[selectedRow!][selectedCol!].add(number);
      }
      notifyListeners();
    }
  }

  void startTime() {
    StartTime = DateTime.now();
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      final now = DateTime.now();
      final temp = now.difference(StartTime!);
      Minutes = temp.inMinutes;
      Seconds = temp.inSeconds % 60 ;
      notifyListeners();
    });
  }

  void stopTime() {
    timer?.cancel();
    timer = null;
  }

  String Time() {
    final minutes = Minutes.toString().padLeft(2, '0');
    final seconds = Seconds.toString().padLeft(2, '0');
    return '$minutes.$seconds';
  }

  double PointComplete() {
    final minutes = Minutes * 60;
    final seconds = Seconds;
    double result = 10000 / (minutes + seconds);
    return double.parse(result.toStringAsFixed(1));
  }

  bool checkEnd(int err_point) {
    if (err_point > 3) {
      return true;
    }
    return false;
  }

  bool completeSudoku(List<List<int>> boardcur, List<List<int>> _fullBoard) {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        //check cột và dòng của cả 2 bảng nếu chỉ cần 1 ô không giống => false
        if (boardcur[i][j] != _fullBoard[i][j]) {
          return false;
        }
      }
    }
    return true;
  }
  
  // Kiểm tra xem một số có thể đặt tại vị trí (row, col) hay không
  bool checkNumberInTable(int num, int row, int col) {
    for (int i = 0; i < 9; i++) {
      if (board[row][i] == num || board[i][col] == num) return false;
    }

    int startRow = row - row % 3;
    int startCol = col - col % 3;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[startRow + i][startCol + j] == num) return false;
      }
    }

    return true;
  }

  // Khởi tạo mảng Sudoku đầy đủ
  bool fillBoard(int row, int col) {
    //điểm kết thúc
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
      if (checkNumberInTable(num, row, col)) {
        board[row][col] = num;
        //đệ quy
        if (fillBoard(row, col + 1)) return true;
        board[row][col] = 0;
      }
    }

    return false;
  }

  // Hàm để khởi tạo mảng Sudoku
  List<List<int>> generateSudoku() {
    fillBoard(0, 0);
    return board;
  }

  void removeDigits(List<List<int>> board, int numToRemove) {
    
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
  List<List<int>> createSudokuPuzzle(String Lever ,int numToRemove) {
    lever = Lever;
    board = List.generate(9, (_) => List.filled(9, 0));
    generateSudoku();
    _fullBoard = _deepCopyBoard(board);
    print(_fullBoard);
    removeDigits(board, numToRemove);
    boardcur = board;
    startTime();
    return board;
  }

  void removeNumber() {
    try {
      if (selectedRow != null && selectedCol != null && editableCells[selectedRow!][selectedCol!]) {
        if(boardcur[selectedRow!][selectedCol!] != 0 ) {
          if (checkCell[selectedRow!][selectedCol!] == false) {
            boardcur[selectedRow!][selectedCol!] = 0;
          }
          notifyListeners();
        }
        else { print("lỗi"); }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Đặt số tại vị trí ô đã chọn
  void placeNumber(int number,context) {
    try {
      if (selectedRow != null && selectedCol != null && editableCells[selectedRow!][selectedCol!]) {
        if (pencil) {
          addPencilBoard(number);
        }
        else {
          if(boardcur[selectedRow!][selectedCol!] == 0 ) {
            if(_fullBoard[selectedRow!][selectedCol!] == number) {
              print("xanh");
              boardcur[selectedRow!][selectedCol!] = number; 
              checkCell[selectedRow!][selectedCol!] = true;
              if (completeSudoku(boardcur, _fullBoard)){
                DialogComplete(context);
                stopTime();
                saveGameResult();
                print("hoàn thành");
              }
              else {
                print("chưa hoàn thành");
              }
            }
            else {
              print("đỏ");
              boardcur[selectedRow!][selectedCol!] = number; 
              checkCell[selectedRow!][selectedCol!] = false;
              errorpoint++;
              if (checkEnd(errorpoint)) {
                stopTime();
                //kiểm tra nếu sai 3 lỗi thì hiện và chơi lại
                DialogEnd(context);
              }
            }
            // boardcur[selectedRow!][selectedCol!] = number;
            notifyListeners();
          }
          else { print("lỗi"); }
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void saveGameResult() async {
  double result = PointComplete();
  int minutes = Minutes;
  int seconds = Seconds;
  String level = lever;

  Map<String, dynamic> gameResult = {
    'result': result,
    'minutes': minutes,
    'seconds': seconds,
    'level': level,
  };

  print(gameResult);
  await DatabaseHelper().insertGameResult(gameResult);
}

  void selectCell(int row, int col) {
    try {
      if (editableCells[row][col]) {
        selectedRow = row;
        selectedCol = col;
        notifyListeners();
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void continueTime(int minutes, int seconds) {
    Minutes = minutes;
    Seconds = seconds;
    StartTime = DateTime.now().subtract(Duration(minutes: minutes, seconds: seconds));
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) async {
      final now = DateTime.now();
      final temp = now.difference(StartTime!);
      Minutes = temp.inMinutes;
      Seconds = temp.inSeconds % 60;
      notifyListeners();
    });
  }

  Future<void> saveGameState() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> boardCurStrings = boardcur.map((row) => row.join(',')).toList();
    List<String> fullBoardStrings = _fullBoard.map((row) => row.join(',')).toList();
    List<String> editableCellsStrings = editableCells.map((row) => row.map((e) => e ? '1' : '0').join(',')).toList();
    List<String> checkCellStrings = checkCell.map((row) => row.map((e) => e ? '1' : '0').join(',')).toList();

    await prefs.setStringList('boardCur', boardCurStrings);
    await prefs.setStringList('fullBoard', fullBoardStrings);
    await prefs.setStringList('editableCells', editableCellsStrings);
    await prefs.setStringList('checkCell', checkCellStrings);

    await prefs.setInt('minutes', Minutes);
    await prefs.setInt('seconds', Seconds);
    await prefs.setInt('errorPoint', errorpoint);
    await prefs.setString('lever', lever);

    List<String> pencilBoardStrings = pencilboard.map((row) =>
      row.map((set) => set.join(',')).toList().join(';')
    ).toList();
    await prefs.setStringList('pencilBoard', pencilBoardStrings);
    await prefs.setInt('suggest', suggest);
  }

  Future<List<List<int>>> loadGameState(context) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? boardCurStrings = prefs.getStringList('boardCur');
    List<String>? fullBoardStrings = prefs.getStringList('fullBoard');
    List<String>? editableCellsStrings = prefs.getStringList('editableCells');
    List<String>? checkCellStrings = prefs.getStringList('checkCell');
    int? error = prefs.getInt('errorPoint');
    String? lever_ = prefs.getString('lever');
    int? m = prefs.getInt('minutes');
    int? s = prefs.getInt('seconds');
    List<String>? pencilBoard = prefs.getStringList('pencilBoard');
    int? sug = prefs.getInt('suggest');
    if (boardCurStrings != null && fullBoardStrings != null && editableCellsStrings != null && checkCellStrings != null) {
      boardcur = boardCurStrings.map((row) => row.split(',').map(int.parse).toList()).toList();
      _fullBoard = fullBoardStrings.map((row) => row.split(',').map(int.parse).toList()).toList();
      editableCells = editableCellsStrings.map((row) => row.split(',').map((e) => e == '1').toList()).toList();
      checkCell = checkCellStrings.map((row) => row.split(',').map((e) => e == '1').toList()).toList();
      errorpoint = error ?? 0;
      lever = lever_ ?? "";
      Minutes = m ?? 0;
      Seconds = s ?? 0;
      continueTime(Minutes, Seconds);
      pencilboard = pencilBoard!.map((row) =>
        row.split(';').map((set) =>
          set.isEmpty ? <int>{} : set.split(',').map(int.parse).toSet()
        ).toList()
      ).toList();
      suggest = sug ?? 0;
    }
    if (lever == "") {
      stopTime();
      DialogContinue(context);
    }
    notifyListeners();
    return boardcur;
  }

  void clearGameState() {
    stopTime();
    board = List.generate(9, (_) => List.filled(9, 0));
    boardcur = List.generate(9, (_) => List.filled(9, 0));
    _fullBoard = List.generate(9, (_) => List.filled(9, 0));
    editableCells = List.generate(9, (_) => List.filled(9, true));
    checkCell = List.generate(9, (_) => List.filled(9, true));
    selectedRow = null;
    selectedCol = null;
    errorpoint = 0;
    Minutes = 0;
    Seconds = 0;
    lever = "";
    pencilboard = List.generate(9, (_) => List.generate(9, (_) => <int>{}));
    suggest = 3;
  }

  void DialogEnd(BuildContext context) {
    //widget remake
    Widget remake = InkWell(
      child: Container(
        alignment: Alignment.center,
        height: ((MediaQuery.of(context).size.height) / 15.0) ,
        width: ((MediaQuery.of(context).size.height) / 10.0),
        decoration: BoxDecoration(
          color: Colors.orange.shade900,
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        child: Text("Chơi lại",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),textAlign: TextAlign.center,),
      ),
      onTap: () {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Sudoku_Screen(lever: lever,type: "new game")),
        );
      },
    );
    showDialog(
      context: context,
      //bắt buộc phải nhấn nút remake 
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(  
          backgroundColor: Colors.amberAccent ,
          shape: RoundedRectangleBorder(
              side:  BorderSide(color: Colors.brown,width: 3),
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          title: Text("Thất bại",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
          textAlign: TextAlign.center,
          ),
          content: Text("Bạn đã sai 3 lỗi !",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
          textAlign: TextAlign.center,
          ),
          actions: [ 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                remake
              ],
            )
          ],  
        );
      },
    );
  }

  void DialogComplete(BuildContext context) {
    //widget remake
    Widget complete = InkWell(
      child: Container(
        alignment: Alignment.center,
        height: ((MediaQuery.of(context).size.height) / 15.0) ,
        width: ((MediaQuery.of(context).size.height) / 10.0),
        decoration: BoxDecoration(
          color: Colors.orange.shade900,
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        child: Text("Về trang chủ",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),textAlign: TextAlign.center,),
      ),
      onTap: () {
        clearGameState();
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => trangchu_Screen()),
        );
      },
    );
    showDialog(
      context: context,
      //bắt buộc phải nhấn nút remake 
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(  
          backgroundColor: Colors.amberAccent ,
          shape: RoundedRectangleBorder(
              side:  BorderSide(color: Colors.brown,width: 3),
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          title: Text("Hoàn thành",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
          textAlign: TextAlign.center,
          ),
          content: Text("Bạn đã hoàn thành trò chơi ở cấp độ $lever với số điểm là ${PointComplete().toString()}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
          textAlign: TextAlign.center,
          ),
          actions: [ 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                complete
              ],
            )
          ],  
        );
      },
    );
  }

  void DialogContinue(BuildContext context) {
    //widget remake
    Widget complete = InkWell(
      child: Container(
        alignment: Alignment.center,
        height: ((MediaQuery.of(context).size.height) / 15.0) ,
        width: ((MediaQuery.of(context).size.height) / 10.0),
        decoration: BoxDecoration(
          color: Colors.orange.shade900,
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        child: Text("Về trang chủ",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),textAlign: TextAlign.center,),
      ),
      onTap: () {
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => trangchu_Screen()),
        );
      },
    );
    showDialog(
      context: context,
      //bắt buộc phải nhấn nút remake 
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(  
          backgroundColor: Colors.amberAccent ,
          shape: RoundedRectangleBorder(
              side:  BorderSide(color: Colors.brown,width: 3),
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          title: Text("Thông báo",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
          textAlign: TextAlign.center,
          ),
          content: Text("Bạn đã hoàn thành trò chơi trước đó",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
          textAlign: TextAlign.center,
          ),
          actions: [ 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                complete
              ],
            )
          ],  
        );
      },
    );
  }
  
  bool check_Cell(int row, int col) => checkCell[row][col];
}