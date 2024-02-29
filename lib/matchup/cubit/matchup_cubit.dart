import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'matchup_state.dart';

class MatchupCubit extends Cubit<MatchupState> {
  MatchupCubit(this._dataRepository, {required this.isHost})
      : super(const MatchupState());

  final IDataRepository _dataRepository;
  final bool isHost;

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
    if (!isHost) return;
    _dataRepository.removePlayer(playerId: int.parse(player.id));
  }

  Future<void> startGame() async {
    if (!isHost) return;
    emit(state.copyWith(statusOfStartGame: FormzStatus.submissionInProgress));
    try {
      await _dataRepository.startGame(rolesDef: state.rolesDef);
      emit(state.copyWith(statusOfStartGame: FormzStatus.submissionSuccess));
    } on DataRepoFailure catch (e) {
      emit(state.copyWith(
        statusOfStartGame: FormzStatus.submissionFailure,
        errorMessage: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(statusOfStartGame: FormzStatus.submissionFailure));
    }
  }

  void resetStatusOfStartGame() {
    emit(state.copyWith(statusOfStartGame: FormzStatus.pure));
  }

  /// helper method for managing extension
  void _emit(MatchupState state) {
    emit(state);
  }
}

extension CharactersCubit on MatchupCubit {
  void addMerlinAndAssassin() =>
      _emit(state.copyWith(hasMerlinAndAssassin: true));
  void omitMerlinAndAssassin() => _emit(state.copyWith(
        hasMerlinAndAssassin: false,
        hasPercivalAndMorgana: false,
        hasOberonAndMordred: false,
      ));

  void addPercivalAndMorgana() =>
      _emit(state.copyWith(hasPercivalAndMorgana: true));
  void omitPercivalAndMorgana() =>
      _emit(state.copyWith(hasPercivalAndMorgana: false));

  void addOberonAndMordred() =>
      _emit(state.copyWith(hasOberonAndMordred: true));
  void omitOberonAndMordred() =>
      _emit(state.copyWith(hasOberonAndMordred: false));
}
