import 'package:darts_scoreboard/models/ui/dart_throw.dart';
import 'player.dart';
import 'dart_turn.dart';

class DartGame {
  final int id;

  final List<Player> players;
  final Player winner;

  final List<DartTurn> turns;
  final int initScore;

  final bool isNorthernBust;
  final bool isDoublingIn;

  final DateTime started;
  final bool isTerminated;

  DartGame({
    this.id,
    this.players,
    this.winner,
    this.turns,
    this.initScore,
    this.isNorthernBust,
    this.isDoublingIn,
    this.started,
    this.isTerminated,
  });

  bool get hasWinner => winner != null;
  bool get canResume => !isTerminated && !hasWinner;
}
