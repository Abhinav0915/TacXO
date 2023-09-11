import 'package:flutter/material.dart';
import 'dart:math';
import 'package:tictactoe/util/appbar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<List<String>> board = [
    ["", "", ""],
    ["", "", ""],
    ["", "", ""],
  ];

  String currentPlayer = "X";
  bool gameOver = false;
  List<int> winningLine = [];

  int computerScore = 0;
  int userScore = 0;

  void makeMove(int row, int col) {
    if (!gameOver && board[row][col] == "") {
      setState(() {
        board[row][col] = "X";
        currentPlayer = "O";
        checkWinner();
        if (!gameOver) {
          computerMove();
        }
      });
    }
  }

  void computerMove() {
    if (!gameOver) {
      List<int> availableCells = [];
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] == "") {
            availableCells.add(i * 3 + j);
          }
        }
      }

      if (availableCells.isNotEmpty) {
        int randomIndex = Random().nextInt(availableCells.length);
        int selectedCell = availableCells[randomIndex];
        int row = selectedCell ~/ 3;
        int col = selectedCell % 3;

        setState(() {
          board[row][col] = "O";
          currentPlayer = "X";
          checkWinner();
        });
      }
    }
  }

  void checkWinner() {
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == board[i][1] && board[i][1] == board[i][2] && board[i][0] != "") {
        gameOver = true;
        winningLine = [i * 3, i * 3 + 1, i * 3 + 2];
        updateScores(board[i][0]);
        return;
      }
      if (board[0][i] == board[1][i] && board[1][i] == board[2][i] && board[0][i] != "") {
        gameOver = true;
        winningLine = [i, i + 3, i + 6];
        updateScores(board[0][i]);
        return;
      }
    }

    if (board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] != "") {
      gameOver = true;
      winningLine = [0, 4, 8];
      updateScores(board[0][0]);
      return;
    }
    if (board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2] != "") {
      gameOver = true;
      winningLine = [2, 4, 6];
      updateScores(board[0][2]);
      return;
    }

    bool isDraw = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == "") {
          isDraw = false;
          break;
        }
      }
    }
    if (isDraw) {
      gameOver = true;
      return;
    }
  }

  void updateScores(String winner) {
    if (winner == "X") {
      userScore++;
    } else if (winner == "O") {
      computerScore++;
    }
  }

  void resetGame() {
    setState(() {
      board = [
        ["", "", ""],
        ["", "", ""],
        ["", "", ""],
      ];
      currentPlayer = "X";
      gameOver = false;
      winningLine = [];
      computerScore = 0;
      userScore = 0;
    });
  }

  BoxDecoration winningBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.red, // Change the color for the winning line
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Welcome To TacXO",
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      'Computer',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      computerScore.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    Text(
                      'User',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      userScore.toString(),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              child: Column(
                children: [
                  for (int row = 0; row < 3; row++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int col = 0; col < 3; col++)
                          GestureDetector(
                            onTap: () {
                              makeMove(row, col);
                            },
                            child: Container(

                              width: 100,
                              height: 100,
                              alignment: Alignment.center,
                              decoration: (gameOver && winningLine.contains(row * 3 + col))
                                  ? winningBoxDecoration(

                              )
                                  : BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                              child: Text(
                                board[row][col],
                                style: TextStyle(

                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              (gameOver)
                  ? (currentPlayer == "X")
                  ? "Computer Wins!"
                  : "User Wins!"
                  : "Current Player: $currentPlayer",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                resetGame();
              },
              child: Text(
                "Restart Game",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
