import 'package:darts_scoreboard/models/ui/player.dart';

class PlayerRepository {
  static final _players = <Player>{
    Player(
      id: 0,
      name: 'Niko',
      gamesWon: 0,
      addedOn: DateTime.now(),
      lastGamePlayedOn: DateTime.now(),
    ),
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
}
