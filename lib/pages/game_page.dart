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

  Function _endTurnAction;

  bool _isDouble;
  bool _isTriple;

  @override
  void initState() {
    super.initState();

    _currentDartTurn = DartTurn(
        id: 0,
        isBust: false,
        dartPlayer: widget.dartGame.players[_currentPlayerIdx],
        throws: []);

    _isDouble = false;
    _isTriple = false;
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

            // status text
            _getStatusText(),

            SizedBox(height: 16.0),

            // score input
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // button grid
                _constructScoreInputGrid(),
                SizedBox(height: 16.0),
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

  _getStatusText() {
    if (_currentDartTurn.isBust) {
      return Text(
        'You\'re busted, pal!',
        style:
            Theme.of(context).textTheme.headline6.copyWith(color: Colors.red),
      );
    } else {
      if (widget.dartGame.hasWinner) {
        return Text(
          '${widget.dartGame.winner.name} has won!',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.green[900]),
        );
      }
    }
    return Text(_endTurnAction == null ? 'Waiting for throw...' : '',
        style: Theme.of(context).textTheme.headline6);
  }

  void makeThrow(int score) {
    if (score != null) {
      final newThrow = DartThrow(
          player: _currentDartTurn.dartPlayer,
          score: score,
          mulitplier: ThrowMultiplier.Single);

      if (_currentDartTurn.throws.length < 3) {
        setState(() {
          _currentDartTurn.throws.add(newThrow);
        });
      }

      // detect bust
      if (_checkIfBust(_currentDartTurn)) {
        setState(() {
          _currentDartTurn.isBust = true;

          // enable the end turn option
          _endTurnAction = endTurn;
        });
      }

      if (_currentDartTurn.throws.length == 3) {
        setState(() {
          // enable the end turn option
          _endTurnAction = endTurn;
        });
      }
    }
  }

  void endTurn() {
    setState(() {
      if (!_currentDartTurn.isBust) {
        _currentDartTurn.dartPlayer.score -= _currentDartTurn.totalScore;
      }

      widget.dartGame.turns.add(_currentDartTurn);

      // check if the player had won
      if (_currentDartTurn.dartPlayer.score == 0) {
        widget.dartGame.winner = _currentDartTurn.dartPlayer.player;

        // disable the end turn option
        _endTurnAction = null;
      } else {
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
        _endTurnAction = null;

        _isDouble = false;
        _isTriple = false;
      }
    });
  }

  bool _checkIfBust(DartTurn dartTurn) {
    // bust conditions:
    //  - score reduced to negative
    //  - score reduced to 1
    //  - score reduced to 0, but the final shot was not a double

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
    // lists the participating players & their respective scores
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
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
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
  }

  _constructScoreInputGrid() {
    if (widget.dartGame.hasWinner) {
      return Table();
    }

    return Table(
      children: <TableRow>[
        // row 1-5
        TableRow(children: [
          _createScoreButton(1),
          _createScoreButton(2),
          _createScoreButton(3),
          _createScoreButton(4),
          _createScoreButton(5),
        ]),
        // row 6-10
        TableRow(children: [
          _createScoreButton(6),
          _createScoreButton(7),
          _createScoreButton(8),
          _createScoreButton(9),
          _createScoreButton(10),
        ]),
        //row 11-15
        TableRow(children: [
          _createScoreButton(11),
          _createScoreButton(12),
          _createScoreButton(13),
          _createScoreButton(14),
          _createScoreButton(15),
        ]),
        // row 16-20
        TableRow(children: [
          _createScoreButton(16),
          _createScoreButton(17),
          _createScoreButton(18),
          _createScoreButton(19),
          _createScoreButton(20),
        ]),
        // control row
        TableRow(children: [
          _createScoreButton(0, usesMultiplier: false), // total miss
          _createScoreButton(25, usesMultiplier: false), // outer bull's eye
          _createScoreButton(50, usesMultiplier: false), // inner bull's eye

          // double toggle
          Container(
            padding: EdgeInsets.all(4.0),
            height: 56.0,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_isDouble) {
                    _isDouble = false;
                  } else {
                    _isTriple = false;
                    _isDouble = true;
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                primary: _isDouble ? Colors.blue[900] : Colors.grey,
              ),
              child: Text("D"),
            ),
          ),

          // triple toggle
          Container(
            padding: EdgeInsets.all(4.0),
            height: 56.0,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_isTriple) {
                    _isTriple = false;
                  } else {
                    _isDouble = false;
                    _isTriple = true;
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                  primary: _isTriple ? Colors.blue[900] : Colors.grey),
              child: Text("T"),
            ),
          ),
        ]),
      ],
    );
  }

  _createScoreButton(int score, {bool usesMultiplier = true}) {
    return Container(
      padding: EdgeInsets.all(4.0),
      height: 56.0,
      child: ElevatedButton(
        onPressed: () {
          if (usesMultiplier) {
            if (_isDouble) {
              makeThrow(score * 2);
            } else if (_isTriple) {
              makeThrow(score * 3);
            } else {
              makeThrow(score);
            }
          } else {
            makeThrow(score);
          }

          setState(() {
            _isDouble = false;
            _isTriple = false;
          });
        },
        style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0)),
        child: Text(_getScoreText(score, usesMultiplier)),
      ),
    );
  }

  _getScoreText(int score, bool usesMultiplier) {
    if (usesMultiplier) {
      if (_isDouble) {
        return 'D${score.toString()}';
      }
      if (_isTriple) {
        return 'T${score.toString()}';
      }
    }
    return score.toString();
  }
}
