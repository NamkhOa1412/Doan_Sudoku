import 'package:flutter/material.dart';
import 'package:sudoku/Untils/custom-text.dart';
import 'package:sudoku/sudoku_trangchu/cls_DiemSo.dart';




class GameResultsScreen extends StatefulWidget {
  @override
  _GameResultsScreenState createState() => _GameResultsScreenState();
}

class _GameResultsScreenState extends State<GameResultsScreen> {
  late Future<List<Map<String, dynamic>>> easyResults;
  late Future<List<Map<String, dynamic>>> hardResults;

  @override
  void initState() {
    super.initState();
    easyResults = DatabaseHelper().fetchGameResultsByLevel("Dễ");
    hardResults = DatabaseHelper().fetchGameResultsByLevel("Khó");
    _fetchHighestResult();
  }
  String _currentLevel = "easy";
  double _highestResult = 0.0;

  Future<void> _fetchHighestResult() async {
     double result = await DatabaseHelper().fetchHighestResult(_currentLevel);
     setState(() {
       _highestResult = result;
     });
   }

    void _changeLevel(String level) {
    setState(() {
      _currentLevel = level;     });
    _fetchHighestResult();
   }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
         title: CustomText(text: "Thành tích", fontWeight: FontWeight.bold,textColor: Colors.white,),
         backgroundColor: Colors.green.shade700,   
          bottom: TabBar(
            tabs: [
              Tab(text: 'Dễ'),
              Tab(text: 'Khó'),
            ],
            indicatorColor: Colors.orange,
            onTap: (index) {
              _changeLevel(index == 0 ? "easy" : "hard");
            },
          ),
          centerTitle: true,
        ),
        body:Column(
          children: [
          //   Text('THÀNH TÍCH',style: TextStyle(
          //   fontSize: 50.0,
          //   fontWeight: FontWeight.bold,
          //   color: Colors.amberAccent,
          //  ), textAlign: TextAlign.center),
           Text(
              "Điểm số cao nhất: ${_highestResult == 0.0 ? 0 : (_highestResult).toInt().toString()}",
               style: TextStyle(fontSize: 40.0),textAlign: TextAlign.center,
             ), 
             Expanded(
              child: TabBarView(
                children: [
                  easyResults == null
                      ? Center(child: Text('Chưa có dữ liệu cho mức độ Dễ.'))
                      : FutureBuilder<List<Map<String, dynamic>>>(
                          future: easyResults,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Lỗi: ${snapshot.error}'));
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(child: Text('Không tìm thấy kết quả'));
                            } else {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  var result = snapshot.data![index];
                                  int diem = (result['result'] as num).toInt();
                                  return ListTile(
                                    title: Text('Điểm số: ${diem.toString()}'),
                                    subtitle: Text('Thời gian: ${result['minutes']}:${result['seconds']}'),
                                  );
                                },
                              );
                            }
                          },
                        ),
                  hardResults == null
                      ? Center(child: Text('Chưa có dữ liệu cho mức độ Khó.'))
                      : FutureBuilder<List<Map<String, dynamic>>>(
                          future: hardResults,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Lỗi: ${snapshot.error}'));
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(child: Text('Không tìm thấy kết quả'));
                            } else {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  var result = snapshot.data![index];
                                  int diemkho = (result['result'] as num).toInt();
                                  return ListTile(
                                    title: Text('Điểm số:  ${diemkho.toString()}'),
                                    subtitle: Text('Thời gian: ${result['minutes']}:${result['seconds']}'),
                                  );
                                },
                              );
                            }
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}