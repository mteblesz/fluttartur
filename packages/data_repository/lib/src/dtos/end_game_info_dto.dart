import '../../model/model.dart';

class EndGameInfoDto {
  int roomId;
  RoomStatus status;

  EndGameInfoDto({
    required this.roomId,
    required this.status,
  });

  factory EndGameInfoDto.fromJson(Map<String, dynamic> json) {
    return EndGameInfoDto(
      roomId: json['roomId'],
      status: RoomStatus.values[json['status']],
    );
  }
}
