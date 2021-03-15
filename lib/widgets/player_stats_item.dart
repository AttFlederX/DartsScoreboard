import 'package:darts_scoreboard/models/ui/player.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlayerStatsItem extends StatelessWidget {
  final Player player;
  final bool isSelected;

  final ValueChanged<bool> onTapped;

  PlayerStatsItem({this.player, this.onTapped, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () => onTapped(isSelected),
        child: Material(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          color: isSelected ? Colors.grey[800] : Colors.white,
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
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: _getTextColor(context)),
                      ),
                      SizedBox(height: 8.0),

                      // player addition date
                      Text(
                        'Added on ${DateFormat.yMMMd().format(player.addedOn)}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: _getTextColor(context)),
                      ),

                      // player last game date
                      if (player.lastGamePlayedOn != null)
                        Text(
                          'Last game played on ${DateFormat.yMMMd().format(player.lastGamePlayedOn)}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: _getTextColor(context)),
                        ),
                    ],
                  ),
                ),

                // player stats
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // games won title
                    Text(
                      'Games won',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: _getTextColor(context)),
                    ),

                    // games won value
                    Text(
                      '${player.gamesWon}',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: _getTextColor(context)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// gets an appropriate text color for a darker backgrround of a selected item
  Color _getTextColor(BuildContext context) {
    return isSelected
        ? Colors.white
        : Theme.of(context).textTheme.headline5.color;
  }
}
