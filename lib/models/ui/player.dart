class Player {
  final int id;

  final String name;
  final int gamesWon;
  final DateTime addedOn;
  final DateTime lastGamePlayedOn;

  const Player({
    this.id,
    this.name,
    this.gamesWon,
    this.addedOn,
    this.lastGamePlayedOn,
  }) : assert(name != null);
}
