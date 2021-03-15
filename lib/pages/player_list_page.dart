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
              onTapped: (isSelected) =>
                  onPlayerSelectionChanged(pl.id, isSelected),
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
            // list of saved players
            : ListView.builder(
                itemBuilder: (_, index) => players[index],
                itemCount: players.length,
                padding: EdgeInsets.only(bottom: 96.0),
              ),

        // create & add controls
        PlayerListControls(
            players: players,
            onPlayerAdded: (newPlayer) {
              setState(() {
                players.add(PlayerStatsItem(
                  player: newPlayer,
                  onTapped: (isSelected) =>
                      onPlayerSelectionChanged(newPlayer.id, isSelected),
                  isSelected: true,
                ));
              });
            }),
      ]),
    );
  }

  onPlayerSelectionChanged(int id, bool isSelected) {
    // find changed player item
    final changedPlayer =
        players.firstWhere((pl) => pl.player.id == id, orElse: () => null);

    if (changedPlayer != null) {
      final newList = List<PlayerStatsItem>.from(players);

      // invert the isSelected flag
      newList[players.indexOf(changedPlayer)] = PlayerStatsItem(
        player: changedPlayer.player,
        onTapped: changedPlayer.onTapped,
        isSelected: !isSelected,
      );

      this.setState(() {
        players = newList;
      });
    }
  }
}

class PlayerListControls extends StatelessWidget {
  PlayerListControls({
    Key key,
    @required this.players,
    @required this.onPlayerAdded,
  }) : super(key: key);

  final List<PlayerStatsItem> players;
  final Function(Player) onPlayerAdded;

  final TextEditingController _newPlayerNameController =
      TextEditingController();

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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return AlertDialog(
                        title: Text('Create new player'),
                        content: TextField(
                          controller: _newPlayerNameController,
                          decoration:
                              InputDecoration(hintText: 'New player name'),
                        ),
                        actions: [
                          TextButton(
                            child: Text('CREATE'),
                            onPressed: () async {
                              // field is empty
                              if (_newPlayerNameController.text.isEmpty) {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      Text('Please enter the player\'s name'),
                                ));
                              } else {
                                // try creating new player
                                var newPlayer =
                                    await PlayerRepository.addPlayer(
                                        _newPlayerNameController.text);

                                if (newPlayer != null) {
                                  // player was created
                                  onPlayerAdded(newPlayer);
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Player added'),
                                  ));
                                } else {
                                  // player already exists
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Player already exists'),
                                  ));
                                }
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 8.0),

          // add player button
          ElevatedButton(
            child: Text('ADD SELECTED PLAYERS'),
            onPressed: () {
              var selectedPlayers = players
                  .where((pl) => pl.isSelected)
                  .map((pl) => pl.player)
                  .toList();

              if (selectedPlayers.length >= minPlayers &&
                  selectedPlayers.length <= maxPlayers) {
                // enough players were selected
                Navigator.pop(context, selectedPlayers);
              } else {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Game must have between 2 and 8 players'),
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}
