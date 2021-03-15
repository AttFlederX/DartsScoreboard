import 'package:darts_scoreboard/models/ui/dart_game.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DartGameItem extends StatelessWidget {
  final DartGame game;

  DartGameItem({this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Material(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              // game data
              Expanded(
                child: Column(
                  children: [
                    // game id & date
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        // id
                        Text(
                          'Game #${game.id + 1}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(width: 8.0),

                        // date
                        Text('${DateFormat.yMMMd().format(game.started)}'),
                      ],
                    ),
                    SizedBox(height: 4.0),

                    // game setup
                    Row(
                      children: [
                        // num of players
                        Text('${game.players.length} players'),
                        SizedBox(width: 4.0),
                        _createCircleSeparator(),
                        SizedBox(width: 4.0),

                        // initial score
                        Text('${game.initScore}'),
                      ],
                    ),
                    SizedBox(height: 4.0),

                    // game options
                    _getGameOptions(),
                  ],
                ),
              ),

              // game state
              _getGameState(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createCircleSeparator() {
    return SizedBox(
      width: 8,
      height: 8,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }

  Widget _getGameOptions() {
    var content = Row(
      children: [],
    );

    if (game.isNorthernBust) {
      content.children.addAll([
        _createCircleSeparator(),
        SizedBox(width: 4.0),
        Text('Northern bust'),
        SizedBox(width: 8.0),
      ]);
    }

    if (game.isDoublingIn) {
      content.children.addAll([
        _createCircleSeparator(),
        SizedBox(width: 4.0),
        Text('Double-in'),
        SizedBox(width: 8.0),
      ]);
    }

    return content;
  }

  Widget _getGameState(BuildContext context) {
    if (game.hasWinner) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'Won by',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.green[900]),
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            '${game.winner.name}',
            style: Theme.of(context).textTheme.bodyText2,
          )
        ],
      );
    } else if (game.isTerminated) {
      return Text(
        'Terminated',
        style:
            Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.red),
      );
    } else {
      return Text(
        'Ongoing',
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: Colors.lightBlue),
      );
    }
  }
}
