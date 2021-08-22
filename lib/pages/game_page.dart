import 'package:darts_scoreboard/models/enums/throw_muliplier.dart';
import 'package:darts_scoreboard/models/ui/dart_game.dart';
import 'package:darts_scoreboard/models/ui/dart_player.dart';
import 'package:darts_scoreboard/models/ui/dart_throw.dart';
import 'package:darts_scoreboard/models/ui/dart_turn.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  final DartGame dartGame;

  GamePage(this.dartGame);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int _currentPlayerIdx = 0;
  DartTurn _currentDartTurn;
  TextEditingController _scoreController;

  Function _throwAction;
  Function _endTurnAction;

  @override
  void initState() {
    super.initState();

    _currentDartTurn = DartTurn(
        id: 0,
        isBust: false,
        dartPlayer: widget.dartGame.players[_currentPlayerIdx],
        throws: []);

    _scoreController = TextEditingController();

    _throwAction = makeThrow;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game'),
      ),
      body: Container(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            // game state
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // now playing
                Column(
                  children: [
                    Text('Now playing'),
                    Text(
                      _currentDartTurn.dartPlayer.player.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),

                // player scores
                _getPlayerScoreItems(widget.dartGame.players),
              ],
            ),

            SizedBox(height: 24.0),

            // throw results
            _getTurnThrowItems(_currentDartTurn.throws),

            SizedBox(height: 16.0),

            // bust indicator
            _currentDartTurn.isBust
                ? Text(
                    'You\'re busted, pal!',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.red),
                  )
                : Text(_endTurnAction == null ? 'Waiting for throw...' : '',
                    style: Theme.of(context).textTheme.headline6),

            SizedBox(height: 16.0),

            // score input
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _scoreController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Score',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _throwAction,
                  child: Text('Throw'),
                ),
                ElevatedButton(
                  onPressed: _endTurnAction,
                  child: Text('End turn'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void makeThrow() {
    final score = int.tryParse(_scoreController.text);
    if (score != null) {
      final newThrow = DartThrow(
          player: _currentDartTurn.dartPlayer,
          score: score,
          mulitplier: ThrowMultiplier.Single);

      if (_currentDartTurn.throws.length < 3) {
        setState(() {
          _currentDartTurn.throws.add(newThrow);
          _scoreController.text = '';
        });
      }

      // detect bust
      if (_checkIfBust(_currentDartTurn)) {
        setState(() {
          _currentDartTurn.isBust = true;

          // enable the end turn option
          _throwAction = null;
          _endTurnAction = endTurn;
        });
      }

      if (_currentDartTurn.throws.length == 3) {
        setState(() {
          // enable the end turn option
          _throwAction = null;
          _endTurnAction = endTurn;
        });
      }

      FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }
  }

  void endTurn() {
    setState(() {
      if (!_currentDartTurn.isBust) {
        _currentDartTurn.dartPlayer.score -= _currentDartTurn.totalScore;
      }

      widget.dartGame.turns.add(_currentDartTurn);

      // move to next player
      if (_currentPlayerIdx < widget.dartGame.players.length - 1) {
        _currentPlayerIdx++;
      } else {
        _currentPlayerIdx = 0;
      }

      // start new turn
      _currentDartTurn = DartTurn(
          id: widget.dartGame.turns.length,
          isBust: false,
          dartPlayer: widget.dartGame.players[_currentPlayerIdx],
          throws: []);

      // disable the end turn option
      _throwAction = makeThrow;
      _endTurnAction = null;
    });
  }

  bool _checkIfBust(DartTurn dartTurn) {
    final playerScore = dartTurn.dartPlayer.score;
    final totalTurnScore = dartTurn.totalScore;

    if (totalTurnScore > playerScore ||
        playerScore - totalTurnScore == 1 ||
        (playerScore - totalTurnScore == 0 &&
            dartTurn.throws.last.mulitplier != ThrowMultiplier.Double)) {
      return true;
    }

    return false;
  }

  _getPlayerScoreItems(List<DartPlayer> dartPlayers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: dartPlayers
          .map((pl) => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(pl.player.name),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(pl.score.toString(),
                      style: Theme.of(context).textTheme.headline6),
                ],
              ))
          .toList(),
    );
  }

  _getTurnThrowItems(List<DartThrow> dartThrows) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: dartThrows
          .map((thr) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Material(
                  elevation: 8.0,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.lightBlueAccent,
                  child: new Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
                    child: Row(
                      children: [
                        Text(thr.formattedTotalScore),

                        // remove button
                        IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                dartThrows.remove(thr);

                                // disable the end turn option
                                _throwAction = makeThrow;
                                _endTurnAction = null;
                              });
                            }),
                      ],
                    ),
                  ),
                ),
              ))
          .toList(),
    );

    _constructScoreInputGrid() {}
  }
}
