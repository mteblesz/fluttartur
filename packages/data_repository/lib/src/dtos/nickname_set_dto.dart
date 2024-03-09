class NicknameSetDto {
  final int roomId;
  final int playerId;
  final String nick;

  NicknameSetDto({
    required this.playerId,
    required this.nick,
    required this.roomId,
  });

  Map<String, dynamic> toJson() {
    if (nick.length < 3) {
      throw StateError('Nick too short');
    }
    if (nick.length > 20) {
      throw StateError('Nick too long');
    }

    return {
      'roomId': roomId,
      'playerId': playerId,
      'nick': nick,
    };
  }
}
