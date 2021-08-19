import 'package:darts_scoreboard/models/enums/throw_muliplier.dart';
import 'dart_player.dart';

class DartThrow {
  final int id;

  final DartPlayer player;
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

  String get formattedTotalScore {
    switch (mulitplier) {
      case ThrowMultiplier.Single:
        return score.toString();
      case ThrowMultiplier.Double:
        return 'D${score.toString()}';
      case ThrowMultiplier.Triple:
        return 'T${score.toString()}';
      case ThrowMultiplier.OuterBullsEye:
        return 'OBE';
      case ThrowMultiplier.InnerBullsEye:
        return 'IBE';
      default:
        return '';
    }
  }
}
