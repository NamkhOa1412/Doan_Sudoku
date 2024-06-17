import 'package:flutter/material.dart';
import 'package:sudoku/sudoku_widget/sudoku_play_screen.dart';

class trangchu_Screen extends StatefulWidget {
  const trangchu_Screen({Key? key}) : super(key: key);

  @override
  State<trangchu_Screen> createState() => _trangchu_ScreenState();
}

class _trangchu_ScreenState extends State<trangchu_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Sudoku_Screen(lever: "Dễ",)));
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
                        image: DecorationImage(image: AssetImage("assets/image_trangchu/ctn.png"),
                        fit: BoxFit.cover)
                      ),
                      
                    ),
                    onTap: () {
                      
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