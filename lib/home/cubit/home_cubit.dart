import 'package:data_repository/data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

/// cubit responsible for routing between lobby, matchup and game layers
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._dataRepository) : super(const HomeState());

  final IDataRepository _dataRepository;

  /// directs to game pages
  void goToGame() {
    _dataRepository.unsubscribeGameStarted();
    emit(state.copyWith(status: HomeStatus.inGame));
  }

  /// directs to matchup page
  void goToMatchup({required bool isHost}) {
    // TODO to be done by a BLoC event maybe?
    _dataRepository.handlePlayerRemoval(handler: leaveRoom);

    emit(state.copyWith(
        status: isHost ? HomeStatus.inMathupIsHost : HomeStatus.inMathup));
  }

  /// directs back to lobby
  void leaveRoom() {
    _dataRepository.unsubscribeGameStarted();
    _dataRepository.leaveRoom();
    emit(state.copyWith(status: HomeStatus.inLobby));
  }

  void subscribeToGameStarted() {
    _dataRepository.subscribeGameStartedWith(doLogic: (gameStarted) {
      if (gameStarted) goToGame();
    });
  }
}
