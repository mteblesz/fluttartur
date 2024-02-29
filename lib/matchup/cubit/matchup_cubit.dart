import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';

part 'matchup_state.dart';

class MatchupCubit extends Cubit<MatchupState> {
  MatchupCubit(this._dataRepository, {required bool isHost})
      : super(MatchupState(isHost: isHost));

  final IDataRepository _dataRepository;

  // debug only
  int debugPlayerCount = 0;
  Future<void> addDummyPlayer() async {
    await _dataRepository.addDummyPlayer(
      nick: "player_$debugPlayerCount",
    );
    debugPlayerCount++;
  }

  void playerCountChanged(List<Player>? players) {
    if (players == null) return;
    emit(state.copyWith(playersCount: players.length));
  }

  bool isPlayerCountValid() {
    return state.playersCount >= 5 && state.playersCount <= 10;
  }

  Future<void> removePlayer(Player player) async {
    _dataRepository.removePlayer(playerId: int.parse(player.id));
  }

  /// handles starting game logic
  Future<void> initGame() async {
    await _dataRepository.startGame(
      state.areMerlinAndAssassinInGame,
      state.arePercivalAreMorganaInGame,
      state.areOberonAndMordredInGame,
    );
  }
}
