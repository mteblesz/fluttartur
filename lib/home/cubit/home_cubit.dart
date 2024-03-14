import 'package:data_repository/data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

/// cubit responsible for routing between lobby, matchup and game layers
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._dataRepository) : super(const HomeState());

  // TODO maybe all database calls from here should be maybe moved
  //to datarepo constructor as handlers when they call methods of this class,
  //else be called when joining or statign rom in methods of data repo

  final IDataRepository _dataRepository;

  /// directs to lobby page
  void goToLobby() {
    emit(state.copyWith(status: HomeStatus.inLobby));
    _dataRepository.unsubscribePlayersList();
    _dataRepository.unsubscribeQuestsSummary();
    _dataRepository.unsubscribeCurrentSquad();
  }

  /// directs to matchup page
  void goToMatchup({required bool isHost}) {
    // TODO to be done by a BLoC event maybe?
    _dataRepository.handlePlayerRemoval(handler: () => goToLobby());
    _dataRepository.handleGameStarted(handler: () => goToGame());
    _dataRepository.subscribePlayersList();

    emit(state.copyWith(
        status: isHost ? HomeStatus.inMathupIsHost : HomeStatus.inMathup));
  }

  /// directs back to lobby
  void leaveMatchup() {
    _dataRepository.leaveMatchup(); // disposes rtu
    goToLobby();
  }

  /// directs to game pages
  void goToGame() {
    _dataRepository.handlePlayerLeftGame(
      // TODO push some notification to the user instead this:
      handler: (p) => goToLobby(),
    );
    _dataRepository.subscribeQuestsSummary();
    _dataRepository.subscribeCurrentSquad();
    emit(state.copyWith(status: HomeStatus.inGame));
  }

  /// directs back to lobby
  void leaveGame() async {
    await _dataRepository.leaveGame(); // disposes rtu
    goToLobby();
  }
}
