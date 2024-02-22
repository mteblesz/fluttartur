import 'package:equatable/equatable.dart';

class Room extends Equatable {
  final String id;
  late bool gameStarted; // TODO to be removed
  final RoomStatus status;
  final String? currentSquadId;

  Room({
    required this.id,
    required this.status,
    required this.currentSquadId,
  }) {
    gameStarted = status.toString() == "Playing";
  }

  /// Empty room which represents that user is currently not in any room.
  static Room empty = Room(
    id: '',
    status: RoomStatus.unknown,
    currentSquadId: '',
  );
  bool get isEmpty => this == Room.empty;
  bool get isNotEmpty => this != Room.empty;

  @override
  List<Object?> get props => [id, status, currentSquadId];
}

enum RoomStatus {
  unknown,
  matchup,
  playing,
  assassination,
  result,
}
