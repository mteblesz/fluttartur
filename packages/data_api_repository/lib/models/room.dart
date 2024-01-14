import 'package:equatable/equatable.dart';

class Room extends Equatable {
  final String id;
  final String hostUserId;
  final bool gameStarted;
  final String currentSquadId;
  final List<String> characters;
  final List<String> specialCharacters;
  final bool? merlinKilled;

  const Room({
    required this.id,
    required this.hostUserId,
    required this.gameStarted,
    required this.currentSquadId,
    required this.characters,
    required this.specialCharacters,
    this.merlinKilled,
  });

  Room.init({required this.hostUserId})
      : id = '',
        gameStarted = false,
        currentSquadId = '',
        characters = <String>[],
        specialCharacters = <String>[],
        merlinKilled = null;

  /// Empty room which represents that user is currently not in any room.
  static const empty = Room(
    id: '',
    hostUserId: '',
    gameStarted: false,
    currentSquadId: '',
    characters: <String>[],
    specialCharacters: <String>[],
    merlinKilled: null,
  );

  /// Convenience getter to determine whether the current room is empty.
  bool get isEmpty => this == Room.empty;

  /// Convenience getter to determine whether the current room is not empty.
  bool get isNotEmpty => this != Room.empty;

  @override
  List<Object?> get props => [
        id,
        hostUserId,
        gameStarted,
        currentSquadId,
        characters,
        specialCharacters,
        merlinKilled,
      ];

  factory Room.fromFirestore() {
    throw UnimplementedError("This method is not implemented yet");
  }

  Map<String, dynamic> toFirestore() {
    throw UnimplementedError("This method is not implemented yet");
  }
}
