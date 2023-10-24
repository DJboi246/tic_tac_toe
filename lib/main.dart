import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:io';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToe();
}

class _TicTacToe extends State<TicTacToe> {
 
  var matrix=["","","","","","","","","",];
  bool Oturn=true;
  int Owin=0;
  int Xwin=0;

  void dowin(){
    setState(() {
        Oturn?Xwin=Xwin+1:Owin=Owin+1;
        showDialog(barrierDismissible: false,context: (context), builder: (BuildContext buildcontext){
          
          return SimpleDialog(
            title: Text("You Won"),
            children: <Widget>[
              Text(Oturn?"X won!":"O won!",),
              TextButton(onPressed: (){setState(() {
                matrix=["","","","","","","","","",];  
                Navigator.of(context).pop();
              });}, child: Text("Next Round"))
            ],
          );
        });
    });
  ;}

  void Checkwin(){
    if(matrix[0]==matrix[1] && matrix[1]==matrix[2] && matrix[0]!=""){
      dowin();
    };
    if(matrix[3]==matrix[4] && matrix[4]==matrix[5] && matrix[3]!=""){
      dowin();
    };
    if(matrix[6]==matrix[7] && matrix[7]==matrix[8] && matrix[6]!=""){
      dowin();
    };
    if(matrix[0]==matrix[3] && matrix[3]==matrix[6] && matrix[0]!=""){
      dowin();
    };
    if(matrix[1]==matrix[4] && matrix[4]==matrix[7] && matrix[1]!=""){
      dowin();
    };
    if(matrix[2]==matrix[5] && matrix[5]==matrix[8] && matrix[2]!=""){
      dowin();
    };
    if(matrix[0]==matrix[4] && matrix[4]==matrix[8] && matrix[0]!=""){
      dowin();
    };
    if(matrix[2]==matrix[4] && matrix[4]==matrix[6] && matrix[2]!=""){
      dowin();
    };
  }
 
  Widget buildButton(index){
    return GestureDetector(
      onTap:(){
      setState(() {
        matrix[index]==""?(Oturn?matrix[index]="O":matrix[index]="X"):Oturn=!Oturn;
        Oturn=!Oturn;
        Checkwin();
      });},
      child:Container(
        height:100.0,
        width:100.0,
        decoration:BoxDecoration(color:Colors.grey,borderRadius: BorderRadius.all(Radius.circular(20))),
        child:Center(child:Text(matrix[index],style:TextStyle(fontSize:40.0)))
      )
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text("Tic Tac Toe")),
      body:Center(
        child:Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("O wins:${Owin}",style: TextStyle(fontSize: 30)),
                  Text(Oturn?"O turn":"X turn",style: TextStyle(fontSize: 30)),
                  Text("X wins:${Xwin}",style: TextStyle(fontSize: 30)),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(padding: EdgeInsets.all(8),child:GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 10,crossAxisSpacing: 10), 
                itemCount: 9,
                itemBuilder: ((context, index) {
                  return buildButton(index);
                }),
              ),)
            ),

            Expanded(
              child: TextButton(onPressed: (){setState(() {
                matrix=["","","","","","","","","",];  
              });}, child: Text("Clear")),
            ),

            Expanded(
              child: TextButton(onPressed: (){setState(() {
                matrix=["","","","","","","","","",];  
                Owin=0;
                Xwin=0;
              });}, child: Text("New Game")),
            ),

            Spacer()

          ],
        )
      )
    );
  }
}