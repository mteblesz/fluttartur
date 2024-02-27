class RoomConnectionDto {
  final int roomId;

  RoomConnectionDto({required this.roomId});

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
    };
  }
}
