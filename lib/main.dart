import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isx = true;
  List<String> displaytxt = ['', '', '', '', '', '', '', '', ''];
  var mytextstyle = TextStyle(color: Colors.white, fontSize: 30);
  int xScore = 0;
  int oScore = 0;
  int filledBox=0;
 static var myNewFont= GoogleFonts.pressStart2p(
   textStyle: TextStyle(color: Colors.black,letterSpacing: 3)
 );
 static var myNewFontWhite=GoogleFonts.pressStart2p(
   textStyle: TextStyle(color: Colors.white,letterSpacing: 3,fontSize: 15)
 );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: Column(
        children: [
          Expanded(
              child: Container(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Player X', style: myNewFontWhite,),
                            Text(xScore.toString(), style: myNewFontWhite,)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Player O", style: myNewFontWhite,),
                            Text(oScore.toString(), style: myNewFontWhite,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Expanded(
            flex: 4,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext, int index) {
                  return GestureDetector(
                    onTap: () {
                      tapped(index, context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepPurple)),
                      child: Center(
                          child: Text(
                            displaytxt[index],
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                    ),
                  );
                }),
          ),
          Expanded(
              child: Container(
                child: Text("TIC TAC TOE",style: myNewFontWhite,),
              )),
        ],
      ),
    );
  }

  void tapped(int i, BuildContext context) {

    setState(() {
      if (isx && displaytxt[i] == '') {
        displaytxt[i] = 'x';
        filledBox+=1;
      } else if (!isx && displaytxt[i] == '') {
        displaytxt[i] = 'o';
        filledBox+=1;
      }
      isx = !isx;
      checkWinner(context);
    });
  }

  void checkWinner(BuildContext context) {
    //r1
    for (int i = 0; i < 9; i += 3) {
      //row
      if (displaytxt[i] == displaytxt[i + 1] &&
          displaytxt[i + 1] == displaytxt[i + 2] &&
          displaytxt[i] != '') {
        _showMyDialog(context, displaytxt[i]);
      }
      //col
    }
    for (int i = 0; i < 3; i++) {
      if (displaytxt[i] == displaytxt[i + 3] &&
          displaytxt[i + 3] == displaytxt[i + 6] &&
          displaytxt[i] != '') {
        _showMyDialog(context, displaytxt[i]);
      }
    }
    //diagonl
    if (displaytxt[0] == displaytxt[4] &&
        displaytxt[4] == displaytxt[8] &&
        displaytxt[0] != '') {
      _showMyDialog(context, displaytxt[0]);
    }
    else if (displaytxt[2] == displaytxt[4] &&
        displaytxt[4] == displaytxt[6] &&
        displaytxt[2] != '') {
      _showMyDialog(context, displaytxt[2]);
    }
    else if(filledBox==9)
      {
        _showDrawDialog(context);
      }

  }
  Future<void> _showDrawDialog(BuildContext context) async {
    void _clearBoard() {
      setState(() {
        for (int i = 0; i < 9; i++) {
          displaytxt[i] = '';
        }
        isx=true;
      });
    }
    filledBox=0;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('!!Draw and the winner is developer!! '),
          actions: <Widget>[
            TextButton(
              child: const Text('Play Again!'),
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog(BuildContext context, String winner) async {
    if (winner == 'o') {
      oScore += 1;
    }
    else {
      xScore += 1;
    }
    void _clearBoard() {
      setState(() {
        for (int i = 0; i < 9; i++) {
          displaytxt[i] = '';
        }
        filledBox=0;
        isx=true;
      });

    }
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('!!Winner!! is ' + winner),
          actions: <Widget>[
            TextButton(
              child: const Text('Play Again!'),
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
