import 'package:darts_scoreboard/models/ui/player.dart';
import 'package:darts_scoreboard/repos/player_repository.dart';
import 'package:darts_scoreboard/widgets/player_stats_item.dart';
import 'package:flutter/material.dart';

class PlayerStatsPage extends StatefulWidget {
  @override
  _PlayerStatsPageState createState() => _PlayerStatsPageState();
}

class _PlayerStatsPageState extends State<PlayerStatsPage> {
  // player list
  List<PlayerStatsItem> players = [];

  @override
  void initState() {
    super.initState();

    players = PlayerRepository.getAllPlayers()
        .map((pl) => PlayerStatsItem(player: pl))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Player stats'),
      ),

      // player list
      body: (players.length == 0)
          // no items placholder
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'No saved players',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            )
          // list of saved games
          : ListView.builder(
              itemBuilder: (_, index) => players[index],
              itemCount: players.length,
            ),
    );
  }
}
