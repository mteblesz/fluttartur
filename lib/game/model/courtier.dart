class Courtier {
  final int playerId;
  final String nick;
  bool isLeader;
  bool isMember;
  bool isCurrentPlayer;

  Courtier({
    required this.playerId,
    required this.nick,
    this.isLeader = false,
    this.isMember = false,
    this.isCurrentPlayer = false,
  });
}
