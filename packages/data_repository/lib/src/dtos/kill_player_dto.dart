class KillPlayerDto {
  int roomId;
  int assassinId;
  int targetId;

  KillPlayerDto({
    required this.roomId,
    required this.assassinId,
    required this.targetId,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'assassinId': assassinId,
      'targetId': targetId,
    };
  }
}
