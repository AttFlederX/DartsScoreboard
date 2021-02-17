import 'package:darts_scoreboard/models/ui/dart_throw.dart';
import 'player.dart';

class DartTurn {
  final int id;

  final Player player;
  final List<DartThrow> throws;
  final bool isBust;

  DartTurn({
    this.id,
    this.player,
    this.throws,
    this.isBust,
  });

  /// Returns the total score of all throws
  int get totalScore =>
      throws.map((thr) => thr.totalScore).fold(0, (scr1, scr2) => scr1 + scr2);
}
