part of 'home_cubit.dart';

enum HomeStatus {
  /// user is not in any room
  inLobby,

  /// user is in room durning matchup
  inMathup,

  /// user is in room durning matchup and is the host
  inMathupIsHost,

  /// user is in room durning game
  inGame,
}

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.inLobby,
  });

  final HomeStatus status;

  @override
  List<Object> get props => [status];

  HomeState copyWith({
    Room? room,
    HomeStatus? status,
  }) {
    return HomeState(
      status: status ?? this.status,
    );
  }
}
