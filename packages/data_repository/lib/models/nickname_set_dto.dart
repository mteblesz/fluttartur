class NicknameSetDto {
  final int playerId;
  final String nick;

  NicknameSetDto({required this.playerId, required this.nick});

  Map<String, dynamic> toJson() {
    if (nick.length < 3 || nick.length > 20) {
      throw StateError('Invalid nick length');
    }

    return {
      'playerId': playerId,
      'nick': nick,
    };
  }
}
