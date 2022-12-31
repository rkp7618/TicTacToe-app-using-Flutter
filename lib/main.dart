import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var gried = [
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
  ];
  var currPlayer = 'X';
  var winner='';
  void drawXo(i) {
    if (gried[i] == '-') {
      setState(() {
        gried[i] = currPlayer;
        currPlayer = (currPlayer == 'X') ? ('O') : ('X');
      });
      findWinner(gried[i]);
    }
  }

  bool checkMove(i1, i2, i3, sign) {
    if(gried[i1]==sign && gried[i2]==sign && gried[i3]==sign)
      {
        return true;
      }
    return false;
  }

  void findWinner(currentSign) {
    if (checkMove(0, 1, 2, currentSign) || //rows
        checkMove(3, 4, 5, currentSign) ||
        checkMove(6, 7, 8, currentSign) ||
        checkMove(0, 3, 6, currentSign) || //Coloumn
        checkMove(1, 4, 7, currentSign) ||
        checkMove(2, 5, 8, currentSign) ||
        checkMove(0, 4, 8, currentSign) || //Diagonal
        checkMove(2, 4, 6, currentSign)) {
      setState(() {
        winner=currentSign;
      });
    }
  }

  //for resetting
  void reset() {
    setState(() {
      winner='';
      gried = [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TicTacToe',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tic Tac Toe'),
        ),
        body:
        Center(
          child: Column(
            children: [
               if(winner!='')Text('$winner Won',style: TextStyle(fontSize: 30),),
              Container(
                constraints:const BoxConstraints(maxHeight: 400, maxWidth: 400),
                margin: EdgeInsets.all(20),
                color: Colors.black,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: gried.length,
                  itemBuilder: (context, index) => Material(
                    color: Colors.amber,
                    child: InkWell(
                      splashColor: Colors.red,
                      onTap: () => drawXo(index),
                      child: Center(
                          child: Text(
                        gried[index],
                        style: TextStyle(fontSize: 50),
                      )),
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                  onPressed: reset,
                  icon: Icon(Icons.refresh),
                  label: Text('Play again'))
            ],
          ),
        ),
      ),
    );
  }
}
