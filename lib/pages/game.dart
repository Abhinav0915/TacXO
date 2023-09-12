import 'package:flutter/material.dart';
import 'dart:math';

import 'package:tictactoe/util/appbar.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late String enteredName;
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ''));
  bool isUserTurn = true; // Flag to track whose turn it is
  bool gameOver = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is String) {
      enteredName = arguments;
    } else {
      enteredName = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xFF011627),
      appBar: MyAppBar(
        title: 'TacXO',
      ),
      body: Column(
        children: [
          const SizedBox(height: 40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  const Text(
                    "Computer",
                    style: TextStyle(
                      fontFamily: 'BlackOpsOne',
                      fontSize: 24.0,
                      letterSpacing: 3.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  const Text(
                    "VS",
                    style: TextStyle(
                      fontFamily: 'BlackOpsOne',
                      fontSize: 20.0,
                      letterSpacing: 3.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Text(
                    enteredName,
                    style: TextStyle(
                      fontFamily: 'BlackOpsOne',
                      fontSize: 24.0,
                      letterSpacing: 3.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                ],
              ),
            ],
          ),
          const SizedBox(height: 100.0),
          Center(
            child: Column(
              children: board.asMap().entries.map((entry) {
                final rowIndex = entry.key;
                final row = entry.value;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: row.asMap().entries.map((cell) {
                    final colIndex = cell.key;
                    final cellValue = cell.value;
                    return GestureDetector(
                      onTap: () {
                        // Check if the cell is empty and the game is not over
                        if (cellValue.isEmpty && !gameOver && isUserTurn) {
                          // Handle the user's move
                          setState(() {
                            board[rowIndex][colIndex] = 'X';
                            isUserTurn = false;
                            checkForWinner('X');
                            if (!gameOver) {
                              // If the game is not over, let the computer make a move
                              makeComputerMove();
                              isUserTurn = true;
                              checkForWinner('O');
                            }
                          });
                        }
                      },
                      child: Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              width: 2.0),
                        ),
                        child: Center(
                          child: Text(
                            cellValue,
                            style: const TextStyle(
                              fontFamily: 'BlackOpsOne',
                              fontSize: 40.0,

                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void checkForWinner(String player) {
    // Check for a win condition (row, column, or diagonal)
    for (int i = 0; i < 3; i++) {
      // Check rows and columns
      if ((board[i][0] == player && board[i][1] == player && board[i][2] == player) ||
          (board[0][i] == player && board[1][i] == player && board[2][i] == player)) {
        // Player wins
        gameOver = true;
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('$player wins!'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    resetGame();
                    Navigator.of(context).pop();
                  },
                  child: Text('Play Again'),
                ),
              ],
            );
          },
        );
        return;
      }
    }

    // Check diagonals
    if ((board[0][0] == player && board[1][1] == player && board[2][2] == player) ||
        (board[0][2] == player && board[1][1] == player && board[2][0] == player)) {
      // Player wins
      gameOver = true;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('$player wins!',
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  resetGame();
                  Navigator.of(context).pop();
                },
                child: Text('Play Again'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Check for a draw (all cells are filled)
    bool isDraw = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          isDraw = false;
          break;
        }
      }
    }

    if (isDraw) {
      gameOver = true;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('It\'s a draw!'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  resetGame();
                  Navigator.of(context).pop();
                },
                child: Text('Play Again'),
              ),
            ],
          );
        },
      );
    }
  }

  void makeComputerMove() {
    // Implement a basic computer move here
    // In this example, the computer picks a random empty cell
    List<int> emptyCells = [];

    // Find all empty cells
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          emptyCells.add(i * 3 + j);
        }
      }
    }

    if (emptyCells.isNotEmpty) {
      // Randomly select an empty cell
      final randomIndex = Random().nextInt(emptyCells.length);
      final selectedCell = emptyCells[randomIndex];
      final rowIndex = selectedCell ~/ 3;
      final colIndex = selectedCell % 3;

      // Make the computer's move
      board[rowIndex][colIndex] = 'O';
    }
  }

  void resetGame() {
    // Reset the game board and flags
    setState(() {
      board = List.generate(3, (_) => List.filled(3, ''));
      isUserTurn = true;
      gameOver = false;
    });
  }
}
