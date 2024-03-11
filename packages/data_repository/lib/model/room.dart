import 'package:equatable/equatable.dart';

class Room extends Equatable {
  final int roomId;
  final RoomStatus status;
  final String? currentSquadId;

  Room({
    required this.roomId,
    required this.status,
    required this.currentSquadId,
  }) {}

  static Room empty = Room(
    roomId: -1,
    status: RoomStatus.unknown,
    currentSquadId: '',
  );
  bool get isEmpty => this == Room.empty;
  bool get isNotEmpty => this != Room.empty;

  @override
  List<Object?> get props => [roomId, status, currentSquadId];
}

enum RoomStatus {
  unknown,
  matchup,
  playing,
  assassination,
  result,
}
