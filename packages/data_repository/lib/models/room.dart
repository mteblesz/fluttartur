import 'package:equatable/equatable.dart';

class Room extends Equatable {
  final String id;
  final bool gameStarted;
  final String? currentSquadId;

  const Room({
    required this.id,
    required this.gameStarted,
    required this.currentSquadId,
  });

  /// Empty room which represents that user is currently not in any room.
  static const empty = Room(
    id: '',
    gameStarted: false,
    currentSquadId: '',
  );
  bool get isEmpty => this == Room.empty;
  bool get isNotEmpty => this != Room.empty;

  @override
  List<Object?> get props => [id, gameStarted, currentSquadId];
}
