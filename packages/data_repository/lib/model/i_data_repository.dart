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
  Future<void> leaveRoom();
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
  Future<List<Player>> getEvilPlayersForGood();
  Future<List<Player>> getGoodPlayersForEvil();
  Future<List<Player>> getGoodPlayersForGood();
  Future<List<Player>> getGoodPlayersForMerlin();
  Stream<SquadInfoDto> streamCurrentSquad();
  void subscribeCurrentSquad();
  void unsubscribeCurrentSquad();

  Stream<List<QuestInfoShortDto>> streamQuestsSummary();
  void subscribeQuestsSummary();
  void unsubscribeQuestsSummary();

//----------------------------------------------------------------------------

  // -------------
  // TODO old stuff for backwards-compatibility during changes (to be removed)

  Future<List<Player>> playersList();

  Stream<List<Player>> streamMembersList();
  Future<void> addMember({
    required int questNumber,
    required String playerId,
    required String nick,
  });
  Future<void> removeMember({
    required int questNumber,
    required String memberId,
  });

  Future<void> submitSquad();
  Future<void> updateSquadIsApproved({bool isApproved = true});
  Future<void> nextSquad({required int questNumber});

  void subscribeSquadIsSubmittedWith({
    String squadId = '',
    required void Function(Squad) doLogic,
  });
  void unsubscribeSquadIsSubmitted();

  String currentSquadId = "";
  void subscribeCurrentSquadIdWith({
    required void Function(String) doLogic,
  });
  void unsubscribeCurrentSquadId();

  voteSquad(bool vote);
  void subscribeSquadVotesWith({
    required void Function(Map<String, bool>) doLogic,
  });
  void unsubscribeSquadVotes();

  Future<bool> isCurrentPlayerAMember();
  Future<void> voteQuest(bool vote);
  void subscribeQuestVotesWith({
    required void Function(List<bool?>) doLogic,
  });
  void unsubscribeQuestVotes();
  Future<void> updateSquadIsSuccessfull({bool isSuccessfull = true});

  Future<List<Squad>> getApprovedSquads();

  Stream<bool?> streamMerlinKilled();
  Future<void> updateMerlinKilled(bool merlinKilled);

  Future<List<bool>> questVotesInfo(int questNumber);
}
