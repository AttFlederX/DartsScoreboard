import 'package:darts_scoreboard/models/ui/player.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlayerStatsItem extends StatefulWidget {
  final Player player;
  final bool isSelectable;

  bool isSelected;

  PlayerStatsItem(
      {this.player, this.isSelectable = false, this.isSelected = false});

  @override
  _PlayerStatsItemState createState() => _PlayerStatsItemState();
}

class _PlayerStatsItemState extends State<PlayerStatsItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          if (widget.isSelectable) {
            setState(() {
              widget.isSelected = !widget.isSelected;
            });
          }
        },
        child: Material(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          color: widget.isSelected ? Colors.grey[800] : Colors.white,
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
                        '${widget.player.name}',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: _getTextColor()),
                      ),
                      SizedBox(height: 8.0),

                      // player addition date
                      Text(
                        'Added on ${DateFormat.yMMMd().format(widget.player.addedOn)}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: _getTextColor()),
                      ),

                      // player last game date
                      if (widget.player.lastGamePlayedOn != null)
                        Text(
                          'Last game played on ${DateFormat.yMMMd().format(widget.player.lastGamePlayedOn)}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: _getTextColor()),
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
                          .copyWith(color: _getTextColor()),
                    ),

                    // games won value
                    Text(
                      '${widget.player.gamesWon}',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: _getTextColor()),
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

  /// gets an appropriate text color for a darker backgraound of a selected item
  Color _getTextColor() {
    return widget.isSelected
        ? Colors.white
        : Theme.of(context).textTheme.headline5.color;
  }
}
