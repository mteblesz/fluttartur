import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';

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
    await _assignLeader();
    await _dataRepository.startGame();
  }

  Future<void> _assignLeader() async {
    final numberOfPlayers = await _dataRepository.playersCount;
    int leaderIndex = Random().nextInt(numberOfPlayers);
    await _dataRepository.assignLeader(leaderIndex);
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
}
