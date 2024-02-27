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
    if (nick.length < 3 || nick.length > 20) {
      throw StateError('Invalid nick length');
    }

    return {
      'roomId': roomId,
      'playerId': playerId,
      'nick': nick,
    };
  }
}
