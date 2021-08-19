import 'package:darts_scoreboard/models/ui/dart_throw.dart';
import 'dart_player.dart';

class DartTurn {
  final int id;

  final DartPlayer dartPlayer;
  final List<DartThrow> throws;
  bool isBust;

  DartTurn({
    this.id,
    this.dartPlayer,
    this.throws,
    this.isBust,
  });

  /// Returns the total score of all throws
  int get totalScore =>
      throws.map((thr) => thr.totalScore).fold(0, (scr1, scr2) => scr1 + scr2);
}
