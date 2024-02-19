import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'dart:math';

part 'matchup_state.dart';

class MatchupCubit extends Cubit<MatchupState> {
  MatchupCubit(this._dataRepository, {required bool isHost})
      : super(MatchupState(isHost: isHost));

  final IDataRepository _dataRepository;

  void playerCountChanged(List<Player>? players) {
    if (players == null) return;
    emit(state.copyWith(playersCount: players.length));
  }

  void nickChanged(String value) {
    value = value.trim();
    final nick = Nick.dirty(value);
    emit(state.copyWith(nick: nick, status: Formz.validate([nick])));
  }

  Future<void> writeinPlayerWithUserId(String userId) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _dataRepository.setNickname(
        nick: state.nick.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> removePlayer(Player player) async {
    _dataRepository.removePlayer(playerId: int.parse(player.id));
  }

  bool isPlayerCountValid() {
    if (kDebugMode) return true;
    return state.playersCount >= 5 && state.playersCount <= 10;
  }

  /// handles starting game logic
  Future<void> initGame() async {
    await _assignLeader();
    await _assignCharacters();
    await _assignSpecialCharacters();
    await _dataRepository.startGame();
  }

  Future<void> _assignLeader() async {
    final numberOfPlayers = await _dataRepository.playersCount;
    int leaderIndex = Random().nextInt(numberOfPlayers);
    await _dataRepository.assignLeader(leaderIndex);
  }

  Future<void> _assignCharacters() async {
    final numberOfPlayers = await _dataRepository.playersCount;
    final characters = defaultCharacters(numberOfPlayers);
    characters.shuffle();
    await _dataRepository.assignCharacters(characters);
  }

  List<String> defaultCharacters(numberOfPlayers) {
    final numberOfEvils = (numberOfPlayers + 2) ~/ 3;
    return List.generate(
      numberOfPlayers,
      (index) => index < numberOfEvils ? 'evil' : 'good',
    );
  }

  Future<void> _assignSpecialCharacters() async {
    // final specialCharacters = _dataRepository.currentRoom.specialCharacters;
    // if (specialCharacters.isEmpty) return;
    // final players = await _dataRepository.playersList();

    // final goodCharacters = specialCharacters.where((c) => c.startsWith('good'));
    // final goodPlayers = players.where((p) => p.team == 'good').toList();
    // goodPlayers.shuffle();
    // final goodMap = Map.fromIterables(
    //     goodCharacters, goodPlayers.take(goodCharacters.length));

    // final evilCharacters = specialCharacters.where((c) => c.startsWith('evil'));
    // final evilPlayers = players.where((p) => p.team == 'evil').toList();
    // evilPlayers.shuffle();
    // final evilMap = Map.fromIterables(
    //     evilCharacters, evilPlayers.take(evilCharacters.length));

    // await _dataRepository.assignSpecialCharacters({...goodMap, ...evilMap});
  }

  // debug only
  Future<void> add_Player_debug() async {
    await _dataRepository.setNickname(
      nick: "player_$debug_player_count",
    );
    debug_player_count++;
  }

  int debug_player_count = 0;
}
