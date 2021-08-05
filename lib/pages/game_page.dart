import 'package:darts_scoreboard/models/ui/dart_game.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  DartGame _dartGame;
  int _currentPlayerIdx = 0;

  @override
  Widget build(BuildContext context) {
    _dartGame = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Game'),
      ),
      body: Column(
        children: [
          // score
          Row(
            children: [
              // now playing
              Column(
                children: [
                  Text('Now playing'),
                  Text('Luis'),
                ],
              ),

              // player scores
              Column(
                children: _getPlayerScores(_dartGame),
              ),
            ],
          ),

          // throw results
          Row(),

          // score input
          Row(),
        ],
      ),
    );
  }

  void makeThrow() {}

  _getPlayerScores(DartGame dartGame) {}
}
