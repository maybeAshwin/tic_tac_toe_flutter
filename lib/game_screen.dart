import 'package:flutter/material.dart';

import 'constants.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> boxValues = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  bool isXTurn = true;

  String getPlayerName(String symbol) {
    return symbol == 'X' ? 'Player 1' : 'Player 2';
  }

  String playerTurnName = '';

  void checkWinner() {
    List<List<int>> winningPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var pattern in winningPatterns) {
      String first = boxValues[pattern[0]];
      if (first != '' &&
          first == boxValues[pattern[1]] &&
          first == boxValues[pattern[2]]) {
        // Found a winner
        showWinnerDialog(first);
        return;
      }
    }

    if (!boxValues.contains('')) {
      showWinnerDialog('Draw');
    }
  }

  void showWinnerDialog(String winner) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Game Over',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (
        context,
        animation,
        secondaryAnimation,
      ) {
        return Center(
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
            child: AlertDialog(
              backgroundColor: const Color(0xFF0066BD,),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                'Game Over!',
                textAlign: TextAlign.center,
                style:kAlertText,
              ),
              content: Text(
                winner == 'Draw'
                    ? 'It\'s a Draw!'
                    : '${getPlayerName(winner)} Wins!',
                textAlign: TextAlign.center,
                style: kTextStyle,
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                  style:kButtonStyle,
                  onPressed: () {
                    Navigator.pop(context);
                    resetGame();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                      'Play Again',
                      style: kTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      boxValues = ['', '', '', '', '', '', '', '', ''];
      isXTurn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0066BD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0066BD),
        title: const Center(
          child: Text(
            'Tic Tac Toe',
            style: kTitleStyle,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 35.0,
                right: 35.0,
                bottom: 100.0,
                top: 30.0,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // 3x3 grid
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                    ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return BoxContainer(
                    value: boxValues[index],
                    onClick: () {
                      setState(() {
                        if (boxValues[index] == '') {
                          boxValues[index] =
                              isXTurn ? 'X' : 'O';
                          isXTurn = !isXTurn; // switch player
                          checkWinner(); // check after every move
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class BoxContainer extends StatelessWidget {
  final String value;
  final VoidCallback onClick;

  const BoxContainer({
    super.key,
    required this.value,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFBD5700),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            value,
            style: kIconTextStyle,
          ),
        ),
      ),
    );
  }
}
