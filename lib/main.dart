import 'package:flutter/material.dart';

import 'game_screen.dart';

void main() {
  runApp(TicTacToe());
}


class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: GameScreen(),
    );
  }
}
