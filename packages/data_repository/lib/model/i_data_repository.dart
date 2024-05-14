import 'dart:async';
import 'package:data_repository/model/model.dart';

/// Temporary measure to ensure compilation of legacy code
abstract class IDataRepository {
  int get currentRoomId;

  Future<void> createAndJoinRoom();
  Future<void> joinRoom({required int roomId});
  Future<void> setNickname({required String nick});
  Future<void> addDummyPlayer({required String nick});

  Stream<List<Player>> streamPlayersList();

  Future<void> removePlayer({required int playerId});
  Future<void> leaveMatchup();
  void handlePlayerRemoval({required void Function() handler});

  Future<void> startGame({required RolesDef rolesDef});
  void handleGameStarted({required void Function() handler});

  TeamRole get currentTeamRole;

  Future<List<Player>> getMerlinAndMorgana();
  Future<List<Player>> getEvilPlayersForMerlin();
  Future<List<Player>> getEvilPlayersForEvil();
  Future<List<Player>> getEvilPlayers();
  Future<List<Player>> getGoodPlayers();

  Future<void> leaveGame();
  Future<List<Player>> getPlayers();
  void handlePlayerLeftGame({required void Function(Player) handler});

  Stream<Squad> streamCurrentSquad();

  Stream<List<QuestInfoShort>> streamQuestsSummary();
  Future<QuestInfo> getQuestInfo({required int squadId});

  int get currentPlayerId;
  Future<void> addMember({required int playerId});
  Future<void> removeMember({required int playerIdOfMember});
  Future<void> submitSquad({required int squadId});
  Future<void> voteSquad({required bool vote, required int squadId});
  Future<void> voteQuest({required bool vote, required int squadId});

  Stream<RoomStatus> streamEndGameInfo();
  Future<void> killPlayer({required int playerId});
}
