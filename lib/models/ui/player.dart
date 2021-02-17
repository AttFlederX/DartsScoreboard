import 'package:flutter/foundation.dart';

class Player {
  final int id;

  final String name;
  final int gamesWon;
  final DateTime addedOn;

  const Player({
    @required this.id,
    @required this.name,
    @required this.gamesWon,
    @required this.addedOn,
  }) : assert(name != null);
}
