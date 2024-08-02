import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  String player1;
  String player2;

  GameScreen({super.key, required this.player1, required this.player2});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> board;
  late String currentplayer;
  late String winner;

  late bool gameover;

  @override
  void initState() {
    super.initState();
    board = List.generate(
      3,
      (_) => List.generate(3, (_) => ""),
    );

    currentplayer = "X";
    winner = "";
    gameover = false;
  }

  void resetgame() {
    setState(() {
      board = List.generate(
        3,
        (_) => List.generate(3, (_) => ""),
      );

      currentplayer = "X";
      winner = "";
      gameover = false;
    });
  }

  void makemove(int row, int col) {
    if (board[row][col] != "" || gameover) {
      return;
    }
    setState(() {
      board[row][col] = currentplayer;

      if (board[row][0] == currentplayer &&
          board[row][1] == currentplayer &&
          board[row][2] == currentplayer) {
        winner = currentplayer;
        gameover = true;
      } else if (board[0][col] == currentplayer &&
          board[1][col] == currentplayer &&
          board[2][col] == currentplayer) {
        winner = currentplayer;
        gameover = true;
      } else if (board[0][0] == currentplayer &&
          board[1][1] == currentplayer &&
          board[2][2] == currentplayer) {
        winner = currentplayer;
        gameover = true;
      } else if (board[0][2] == currentplayer &&
          board[1][1] == currentplayer &&
          board[2][0] == currentplayer) {
        winner = currentplayer;
        gameover = true;
      } else if (board[0][1] == currentplayer &&
          board[1][1] == currentplayer &&
          board[2][1] == currentplayer) {
        winner = currentplayer;
        gameover = true;
      } else if (board[0][2] == currentplayer &&
          board[1][2] == currentplayer &&
          board[2][2] == currentplayer) {
        winner = currentplayer;
        gameover = true;
      } else if (board[2][0] == currentplayer &&
          board[2][1] == currentplayer &&
          board[2][2] == currentplayer) {
        winner = currentplayer;
        gameover = true;
      }

      currentplayer = currentplayer == "X" ? "0" : "X";

      if (!board.any((row) => row.any(
            (col) => col == "",
          ))) {
        gameover = true;
        winner = "It's a Tie";
      }

      if (winner != "") {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            btnOkText: "Play again",
            title: winner == "X"
                ? widget.player1 + "Won!"
                : winner == "0"
                    ? widget.player2 + "Won!"
                    : "It's a Tie",
            btnOkOnPress: () {
              resetgame();
            })
          ..show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff323D5B),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Turn : ",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    currentplayer == "X"
                        ? widget.player1 + " ($currentplayer)"
                        : widget.player2 + " ($currentplayer)",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: currentplayer == "X" ? Colors.green : Colors.red,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff5f6b84),
                      borderRadius: BorderRadius.circular(10)),
                  child: GridView.builder(
                    itemCount: 9,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      int row = index ~/ 3;
                      int col = index % 3;
                      return GestureDetector(
                        onTap: () => makemove(row, col),
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              board[row][col],
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: board[row][col] == "X"
                                      ? Colors.green
                                      : Colors.red),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
