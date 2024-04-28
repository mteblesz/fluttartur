import 'package:data_repository/data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final IDataRepository _dataRepository;

  GameCubit(this._dataRepository) : super(const GameState());

  Stream<List<Player>> streamPlayersList() {
    return _dataRepository.streamPlayersList();
  }

  Stream<List<Player>> streamMembersList() {
    return _dataRepository.streamPlayersList(); // TODO
  }

  Future<List<Player>> getEvilPlayers() {
    return _dataRepository.getEvilPlayers();
  }

  Future<List<Player>> getMerlinAndMorgana() {
    return _dataRepository.getMerlinAndMorgana();
  }

  bool squadFullSize(int playersCount, int questNumber) {
    return true; // TODO wrong wrong
  }

  bool isTwoFailsQuest(int playersCount, int questNumber) {
    return false; // TODO wrong wrong
  }

  //--------------------------------leader's logic------------------------------

  /// add player to squad
  Future<void> addMember({required Player player}) async {
    //if (!_dataRepository.currentPlayer.isLeader) return;
    if (state.status != GameStatus.squadChoice) return;

    if (state.isSquadFull) return;

    await _dataRepository.addMember(
      questNumber: state.questNumber,
      playerId: player.playerId,
      nick: player.nick,
    );

    final isSquadFull = true;
    emit(state.copyWith(isSquadFull: isSquadFull));
  }

  /// remove player from squad
  Future<void> removeMember({required Player member}) async {
    //if (!_dataRepository.currentPlayer.isLeader) return;
    if (state.status != GameStatus.squadChoice) return;

    await _dataRepository.removeMember(
      questNumber: state.questNumber,
      memberId: member.playerId,
    );

    emit(state.copyWith(isSquadFull: false));
  }

  Future<void> submitSquad() async {
    final isSquadRequiredSize = true;
    if (!isSquadRequiredSize) return;
    await _dataRepository.submitSquad();
  }

  //--------------------------------players's logic-----------------------------

  Future<void> voteSquad(bool vote) async {
    await _dataRepository.voteSquad(vote);
  }

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
        if (squad.isSuccessfull == null) return;
        emit(state.copyWith(
            questStatuses: state.insertToQuestStatuses(
          squad.isSuccessfull == true
              ? QuestStatus.successful
              : QuestStatus.failed,
        )));

        emit(state.copyWith(lastQuestOutcome: squad.isSuccessfull));
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
    return _dataRepository.isCurrentPlayerAMember();
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

  Future<List<Player>> listOfGoodPlayers() async {
    return await _dataRepository.playersList();
  }

  //--------------------------------quest info logic----------------------------

  Future<List<bool>>? questVotesInfo(int questNumber) async {
    final questStatus = state.questStatuses[questNumber - 1];
    if (questStatus != QuestStatus.successful &&
        questStatus != QuestStatus.failed) {
      return List<bool>.empty();
    }
    return await _dataRepository.questVotesInfo(questNumber);
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
