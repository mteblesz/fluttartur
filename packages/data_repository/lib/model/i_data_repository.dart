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
  void subscribePlayersList();
  void unsubscribePlayersList();

  Future<void> removePlayer({required int playerId});
  Future<void> leaveMatchup();
  void handlePlayerRemoval({required void Function() handler});

  Future<void> startGame({required RolesDef rolesDef});
  void handleGameStarted({required void Function() handler});

  // -------------
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
  void subscribeCurrentSquad();
  void unsubscribeCurrentSquad();

  Stream<List<QuestInfoShort>> streamQuestsSummary();
  void subscribeQuestsSummary();
  void unsubscribeQuestsSummary();
  Future<QuestInfo> getQuestInfo({required int squadId});

  int get currentPlayerId;
  Future<void> addMember({required int playerId});
  Future<void> removeMember({required int playerIdOfMember});
  Future<void> submitSquad({required int squadId});
  Future<void> voteSquad(bool vote);
  Future<void> voteQuest(bool vote);

//----------------------------------------------------------------------------

  // -------------
  // TODO old stuff for backwards-compatibility during changes (to be removed)

  Future<bool> isCurrentPlayerAMember();

  Stream<bool?> streamMerlinKilled();
  Future<void> updateMerlinKilled(bool merlinKilled);
}
