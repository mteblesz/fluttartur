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
    this.playerLeftGame = false,
    this.message = "",
  });

  final HomeStatus status;

  final bool playerLeftGame;
  final String message;

  @override
  List<Object> get props => [status, playerLeftGame, message];

  HomeState copyWith({
    HomeStatus? status,
    bool? playerLeftGame,
    String? message,
  }) {
    return HomeState(
      status: status ?? this.status,
      playerLeftGame: playerLeftGame ?? this.playerLeftGame,
      message: message ?? this.message,
    );
  }
}
