part of 'game_cubit.dart';

class GameState extends Equatable {
  final RoomStatus status;

  const GameState({
    this.status = RoomStatus.unknown,
  });

  @override
  List<Object> get props => [
        status,
      ];

  GameState copyWith({
    RoomStatus? status,
  }) {
    return GameState(
      status: status ?? this.status,
    );
  }
}
