import 'package:flutter/material.dart';

class TicTacToe extends StatelessWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe Game',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool oTurn = true;
  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Player X',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      Text(
                        xScore.toString(),
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Player O',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      Text(
                        oScore.toString(),
                        style: TextStyle(fontSize: 20, color: Colors.green),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
          Expanded(
            flex: 4,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      onTapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                        child: Text(
                          displayElement[index],
                          style: TextStyle(
                            color: getColor(displayElement[index]),
                            fontSize: 35,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 60,
                  color: Colors.blue,
                  child: TextButton(
                    onPressed: clearScoreBoard,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Clear Score Board',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  Color getColor(String player) {
    if (player == 'O') {
      return Colors.green;
    }
    return Colors.red;
  }

  void clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
    });
    filledBoxes = 0;
  }

  void clearScoreBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;

      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
    });

    filledBoxes = 0;
  }

  void onTapped(int index) {
    setState(() {
      if (oTurn && displayElement[index] == '') {
        displayElement[index] = 'O';
        filledBoxes++;
      } else if (!oTurn && displayElement[index] == '') {
        displayElement[index] = 'X';
        filledBoxes++;
      }

      oTurn = !oTurn;

      checkWinner();
    });
  }

  void checkWinner() {
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != '') {
      showdialogBox(displayElement[0]);
    } else if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != '') {
      showdialogBox(displayElement[3]);
    } else if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '') {
      showdialogBox(displayElement[6]);
    } else if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '') {
      showdialogBox(displayElement[0]);
    } else if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '') {
      showdialogBox(displayElement[1]);
    } else if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '') {
      showdialogBox(displayElement[2]);
    } else if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '') {
      showdialogBox(displayElement[0]);
    } else if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != '') {
      showdialogBox(displayElement[2]);
    } else if (filledBoxes == 9) {
      showDrawDialogBox();
    }
  }

  void showdialogBox(String playerName) {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black38,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("\" " + playerName + " \"is Winner!!"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    clearBoard();
                    Navigator.of(context).pop();
                  },
                  child: Text('Play Again!!'))
            ],
          );
        });

    if (playerName == 'O') {
      oScore++;
    } else {
      xScore++;
    }
  }

  void showDrawDialogBox() {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black38,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Draw"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    clearBoard();
                    Navigator.of(context).pop();
                  },
                  child: Text('Play Again!!'))
            ],
          );
        });
  }
}
