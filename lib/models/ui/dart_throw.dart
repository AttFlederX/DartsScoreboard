import 'package:darts_scoreboard/models/enums/throw_muliplier.dart';
import 'player.dart';

class DartThrow {
  final int id;

  final Player player;
  final int score;
  final ThrowMultiplier mulitplier;
  final bool isBust;

  DartThrow({
    this.id,
    this.player,
    this.score,
    this.mulitplier,
    this.isBust,
  });

  int get totalScore {
    switch (mulitplier) {
      case ThrowMultiplier.Single:
        return score;
      case ThrowMultiplier.Double:
        return score * 2;
      case ThrowMultiplier.Triple:
        return score * 3;
      case ThrowMultiplier.OuterBullsEye:
        return 25;
      case ThrowMultiplier.InnerBullsEye:
        return 50;
      default:
        return 0;
    }
  }
}
