import 'dart_player.dart';
import 'player.dart';
import 'dart_turn.dart';

class DartGame {
  final int id;

  final List<DartPlayer> players;
  Player winner;

  final List<DartTurn> turns;
  final int initScore;

  final bool hasNoFinalThrowRules;
  final bool isDoublingIn;

  final DateTime started;
  final bool isTerminated;

  DartGame({
    this.id,
    this.players,
    this.winner,
    this.turns,
    this.initScore,
    this.hasNoFinalThrowRules,
    this.isDoublingIn,
    this.started,
    this.isTerminated,
  });

  bool get hasWinner => winner != null;
  bool get canResume => !isTerminated && !hasWinner;
}
