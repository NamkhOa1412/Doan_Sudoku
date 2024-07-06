import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudoku/sudoku_trangchu/screen_ThanhTich.dart';
import 'package:sudoku/sudoku_widget/sudoku_play_screen.dart';


class trangchu_Screen extends StatefulWidget {
  const trangchu_Screen({Key? key}) : super(key: key);

  @override
  State<trangchu_Screen> createState() => _trangchu_ScreenState();
}

class _trangchu_ScreenState extends State<trangchu_Screen> {
  @override
  Widget build(BuildContext context) {
    // final Lever = context.watch<SudokuStart>().lever;
    // Provider.of<SudokuStart>(context, listen: false).loadGameState();
    return Scaffold(
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => GameResultsScreen()),);
         
        },
        child: Image.asset('assets/image_trangchu/nut.png'),
        backgroundColor: Colors.transparent, // Đặt màu nền trong suốt (nếu cần)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/image_trangchu/h4.jpg"),
        fit: BoxFit.fill)
      ),
       child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              // Container(
              //   height: ((MediaQuery.of(context).size.height) / 50.0),
              // )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    
                    child: Container(
                      
                      height: ((MediaQuery.of(context).size.height) / 15.0) ,
                      width: ((MediaQuery.of(context).size.height) / 5.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/image_trangchu/sta.png"),
                        fit: BoxFit.cover)
                      ),
                      
                    ),
                    onTap: () {
                      showAlertDialog(context);
                    },
                  ),
                  Container(
                     height: ((MediaQuery.of(context).size.height) / 20.0) ,
                      
                  ),
                  InkWell(
                    
                    child:Container(
                      height: ((MediaQuery.of(context).size.height) / 15.0) ,
                      width: ((MediaQuery.of(context).size.height) / 5.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/image_trangchu/ctn.png"),
                        fit: BoxFit.cover)
                      ),
                      
                    ),
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Sudoku_Screen(lever: "", type: "continue")),
                      );
                      // print(Provider.of<SudokuStart>(context, listen: false).lever);
                    },
                  ),
                    Container(
                     height: ((MediaQuery.of(context).size.height) / 20.0) ,
                      
                  ),
                  InkWell(
                    
                    child: Container(
                      height: ((MediaQuery.of(context).size.height) / 15.0) ,
                      width: ((MediaQuery.of(context).size.height) / 5.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/image_trangchu/ext.png"),
                        fit: BoxFit.cover)
                      ),
                      
                    ),
                    onTap: () {
                      SystemNavigator.pop();
                    },
                  )
                  
                   
                ],
              )
            ],
          ),
        ],
       ),
    ),
    );
  }
}
showAlertDialog(BuildContext context) {  
  // Create button  
  Widget easyButton = InkWell(
                    
                    child: Container(
                      height: ((MediaQuery.of(context).size.height) / 15.0) ,
                      width: ((MediaQuery.of(context).size.height) / 10.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/image_trangchu/btn_easy.png"),
                        fit: BoxFit.fill)
                      ),
                      
                    ),
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Sudoku_Screen(lever: "Dễ",type: "new game",)));
                    },
                  );
  Widget hardButton = InkWell(
                    
                    child: Container(
                      height: ((MediaQuery.of(context).size.height) / 15.0) ,
                      width: ((MediaQuery.of(context).size.height) / 10.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/image_trangchu/btn_Hard.png"),
                        fit: BoxFit.fill)
                      ),
                      
                    ),
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Sudoku_Screen(lever: "Khó",type: "new game")));
                      
                    },
                  );
  
  // Create AlertDialog  
  AlertDialog alert = AlertDialog(  
    backgroundColor: Colors.amberAccent ,
    shape: RoundedRectangleBorder(
        side:  BorderSide(color: Colors.brown,width: 3),
        borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    title: Text("MODE",
    style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.white
    ),
    textAlign: TextAlign.center,
    ),  
    content: null ,  
    actions: [  
      // easyButton,
      // hardButton,  
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          easyButton,
          hardButton,
        ],
      )
    ],  
  );  
  
  // show the dialog  
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  );  
} 