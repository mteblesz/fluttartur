class PlayerRemoveDto {
  final int playerId;
  final int roomId;

  PlayerRemoveDto({required this.playerId, required this.roomId});

  Map<String, dynamic> toJson() {
    return {
      'playerId': playerId,
      'nick': roomId,
    };
  }
}
