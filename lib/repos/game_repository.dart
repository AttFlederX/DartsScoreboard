import 'package:darts_scoreboard/models/ui/dart_game.dart';
import 'package:darts_scoreboard/repos/player_repository.dart';

class GameRepository {
  static final _players = PlayerRepository.getAllPlayers();

  static final _games = <DartGame>{
    DartGame(
      id: 0,
      initScore: 301,
      isDoublingIn: true,
      isNorthernBust: true,
      isTerminated: false,
      players: [
        _players[0],
        _players[1],
      ],
      started: DateTime.now(),
      winner: null,
      turns: [],
    ),
    DartGame(
      id: 1,
      initScore: 701,
      isDoublingIn: false,
      isNorthernBust: false,
      isTerminated: false,
      players: [
        _players[1],
        _players[2],
      ],
      started: DateTime.now(),
      winner: _players[1],
      turns: [],
    ),
    DartGame(
      id: 2,
      initScore: 501,
      isDoublingIn: true,
      isNorthernBust: false,
      isTerminated: false,
      players: [
        _players[0],
        _players[2],
      ],
      started: DateTime.now(),
      winner: null,
      turns: [],
    ),
  };

  static List<DartGame> getAllGames() {
    return _games.toList();
  }
}
