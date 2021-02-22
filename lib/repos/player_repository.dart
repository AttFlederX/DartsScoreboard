import 'package:darts_scoreboard/models/ui/player.dart';

class PlayerRepository {
  static final _players = <Player>{
    Player(
        id: 0,
        name: 'Niko',
        gamesWon: 0,
        addedOn: DateTime.now(),
        lastGamePlayedOn: null),
    Player(
      id: 1,
      name: 'Roman',
      gamesWon: 5,
      addedOn: DateTime.now(),
      lastGamePlayedOn: DateTime.now(),
    ),
    Player(
      id: 2,
      name: 'Luis',
      gamesWon: 999,
      addedOn: DateTime.fromMillisecondsSinceEpoch(1000000),
      lastGamePlayedOn: DateTime.now(),
    ),
  };

  static List<Player> getAllPlayers() {
    return _players.toList();
  }

  static bool verifyName(String name) {
    return !_players.any((pl) => pl.name == name);
  }

  static Future<Player> addPlayer(String name) async {
    if (!verifyName(name)) {
      return null;
    }

    var newPlayer = Player(
      id: _players.length,
      name: name,
      addedOn: DateTime.now(),
      gamesWon: 0,
      lastGamePlayedOn: null,
    );
    _players.add(newPlayer);

    return newPlayer;
  }
}
