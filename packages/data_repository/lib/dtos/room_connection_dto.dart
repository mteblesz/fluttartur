class RoomConnectionDto {
  final int roomId;
  final String hubConnectionId;

  RoomConnectionDto({required this.roomId, required this.hubConnectionId});

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'hubConnectionId': hubConnectionId,
    };
  }
}
