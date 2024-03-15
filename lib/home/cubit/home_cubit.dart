import 'package:data_repository/data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

/// cubit responsible for routing between lobby, matchup and game layers
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._dataRepository) : super(const HomeState());

  final IDataRepository _dataRepository;

  /// directs to lobby page
  void _goToLobby() {
    emit(state.copyWith(status: HomeStatus.inLobby));
  }

  /// directs to matchup page
  void goToMatchup({required bool isHost}) {
    // TODO to be done by a BLoC event maybe?
    _dataRepository.handlePlayerRemoval(handler: () => _goToLobby());
    _dataRepository.handleGameStarted(handler: () => goToGame());
    emit(state.copyWith(
        status: isHost ? HomeStatus.inMathupIsHost : HomeStatus.inMathup));
  }

  /// directs back to lobby
  void leaveMatchup() {
    _dataRepository.leaveMatchup(); // disposes rtu
    _goToLobby();
  }

  /// directs to game pages
  void goToGame() {
    // TODO push some notification to the user instead this:
    _dataRepository.handlePlayerLeftGame(handler: (p) => leaveGame());
    emit(state.copyWith(status: HomeStatus.inGame));
  }

  /// directs back to lobby
  void leaveGame() async {
    await _dataRepository.leaveGame(); // disposes rtu
    _goToLobby();
  }
}
