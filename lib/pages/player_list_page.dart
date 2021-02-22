import 'package:darts_scoreboard/helpers/consts.dart';
import 'package:darts_scoreboard/models/ui/player.dart';
import 'package:darts_scoreboard/repos/player_repository.dart';
import 'package:darts_scoreboard/widgets/player_stats_item.dart';
import 'package:flutter/material.dart';

class PlayerListPage extends StatefulWidget {
  final List<Player> selectedPlayers;

  PlayerListPage(this.selectedPlayers);

  @override
  _PlayerListPageState createState() => _PlayerListPageState();
}

class _PlayerListPageState extends State<PlayerListPage> {
  // player list
  List<PlayerStatsItem> players = [];

  @override
  void initState() {
    super.initState();

    players = PlayerRepository.getAllPlayers()
        .map((pl) => PlayerStatsItem(
              player: pl,
              isSelectable: true,
              isSelected: widget.selectedPlayers.any((spl) => spl.id == pl.id),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add player'),
      ),

      // player list
      body: Stack(children: [
        (players.length == 0)
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

        // create & add controls
        PlayerListControls(players: players)
      ]),
    );
  }
}

class PlayerListControls extends StatelessWidget {
  const PlayerListControls({
    Key key,
    @required this.players,
  }) : super(key: key);

  final List<PlayerStatsItem> players;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // create player button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 8.0),

          // add player button
          RaisedButton(
            child: Text('ADD SELECTED PLAYERS'),
            onPressed: () {
              var selectedPlayers = players
                  .where((pl) => pl.isSelected)
                  .map((pl) => pl.player)
                  .toList();

              if (selectedPlayers.length >= minPlayers &&
                  selectedPlayers.length <= maxPlayers) {
                Navigator.pop(context, selectedPlayers);
              } else {
                Scaffold.of(context).removeCurrentSnackBar();
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Game must have between 2 and 8 players'),
                ));
              }
            },
          ),
          SizedBox(height: 48.0),
        ],
      ),
    );
  }
}
