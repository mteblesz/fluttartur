import 'package:data_repository/data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final IDataRepository _dataRepository;

  GameCubit(this._dataRepository) : super(const GameState());

  Future<List<Player>> getEvilPlayers() {
    return _dataRepository.getEvilPlayers();
  }

  Future<List<Player>> getMerlinAndMorgana() {
    return _dataRepository.getMerlinAndMorgana();
  }

  //--------------------------------------------------------------
  //-------------------------------------------------------------

  /// steering the game course through states and squad props
  Future<void> doSquadLoop(Squad squad) async {
    emit(state.copyWith(questNumber: squad.questNumber)); // update questNumber
    switch (state.status) {
      case GameStatus.squadChoice:
        if (squad.isSubmitted) {
          emit(state.copyWith(status: GameStatus.squadVoting));
        }
        break;
      case GameStatus.squadVoting:
        if (squad.isApproved == null) return;
        if (squad.isApproved!) {
          emit(state.copyWith(status: GameStatus.questVoting));
        } else {
          emit(state.copyWith(status: GameStatus.squadChoice));
        }
        break;
      case GameStatus.questVoting:
        if (squad.isSuccessful == null) return;
        emit(state.copyWith(
            questStatuses: state.insertToQuestStatuses(
          squad.isSuccessful == true
              ? QuestStatus.successful
              : QuestStatus.failed,
        )));

        emit(state.copyWith(lastQuestOutcome: squad.isSuccessful));
        emit(state.copyWith(status: GameStatus.questResults));
        break;
      case GameStatus.questResults:
        break;
      case GameStatus.gameResults:
        break;
    }
  }

  Future<void> closeQuestResults() async {
    final winningTeam = true;
    if (winningTeam == null) {
      emit(state.copyWith(status: GameStatus.squadChoice));
      emit(state.copyWith(
          questStatuses: state.insertToQuestStatuses(QuestStatus.ongoing)));
      emit(state.copyWith(isSquadFull: false));
    } else {
      emit(state.copyWith(winningTeam: winningTeam));
      emit(state.copyWith(status: GameStatus.gameResults));
    }
  }

  Future<bool> isCurrentPlayerAMember() async {
    return true;
    //_dataRepository.isCurrentPlayerAMember();
  }

  //--------------------------------merlin killing logic------------------------

  bool assassinPresent() => false;
  //_dataRepository.currentRoom.specialCharacters.contains("evil_assassin");

  bool isAssassin() => false;
  //_dataRepository.currentPlayer.role == "evil_assassin";

  Stream<bool?> streamMerlinKilled() {
    return _dataRepository.streamMerlinKilled();
  }

  Future<void> killPlayer({required Player player}) async {
    //await _dataRepository.updateMerlinKilled(player.role == "good_merlin");
  }
}

class MembersLimitExceededFailure implements Exception {
  const MembersLimitExceededFailure(
      [this.message = 'There shouldn\'t be that many members in squad']);

  final String message;
}

class SquadMissingFieldOnResultsFailure implements Exception {
  const SquadMissingFieldOnResultsFailure(
      [this.message =
          'Squad is approved but field is_successful field is missing, '
              'while user displays quest results.']);

  final String message;
}
