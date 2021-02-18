import 'package:darts_scoreboard/models/ui/player.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlayerStatsItem extends StatelessWidget {
  final Player player;

  PlayerStatsItem({this.player});

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
              // player name & data
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // player name
                    Text(
                      '${player.name}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 8.0),

                    // player addition date
                    Text(
                        'Added on ${DateFormat.yMMMd().format(player.addedOn)}'),

                    // player last game date
                    Text(
                        'Last game played on ${DateFormat.yMMMd().format(player.lastGamePlayedOn)}'),
                  ],
                ),
              ),

              // player stats
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // games won title
                  Text('Games won'),

                  // games won value
                  Text(
                    '${player.gamesWon}',
                    style: Theme.of(context).textTheme.headline4,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
