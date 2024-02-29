import 'dart:async';
import 'package:data_repository/models/models.dart';

import '../models/courtier.dart';

/// Temporary measure to ensure compilation of legacy code
abstract class IDataRepository {
  Future<Room> getRoomById();
  int get currentRoomId;

  Future<void> createAndJoinRoom();
  Future<void> joinRoom({required int roomId});
  Future<void> setNickname({required String nick});
  Future<void> addDummyPlayer({required String nick});
  Future<void> removePlayer({required int playerId});
  Future<void> leaveRoom();
  void handlePlayerRemoval({required void Function() handler});

  Stream<List<Player>> streamPlayersList();
  void subscribePlayersList();
  void unsubscribePlayersList();

  // TODO old stuff for backwards-compatibility during changes (to be removed)

  Stream<Room> streamRoom();
  Future<void> startGame(
    bool areMerlinAndAssassinInGame,
    bool arePercivalAreMorganaInGame,
    bool areOberonAndMordredInGame,
  );
  void subscribeGameStartedWith({required void Function(bool) doLogic});
  void unsubscribeGameStarted();

  Player get currentPlayer;
  Courtier get currentCourtier;
  Stream<Player> streamPlayer();

  Future<List<Player>> playersList();
  Future<List<Courtier>> courtiersList(); // breaking change
  Future<int> get playersCount;

  Stream<List<Member>> streamMembersList({required squadId});
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
  Stream<String> streamCurrentSquadId();

  voteSquad(bool vote);
  void subscribeSquadVotesWith({
    required void Function(Map<String, bool>) doLogic,
  });
  void unsubscribeSquadVotes();

  Future<String?> _getMemberIdWith({required Player player});

  Future<bool> isCurrentPlayerAMember();
  Future<void> voteQuest(bool vote);
  void subscribeQuestVotesWith({
    required void Function(List<bool?>) doLogic,
  });
  void unsubscribeQuestVotes();
  Future<void> updateSquadIsSuccessfull({bool isSuccessfull = true});

  Future<List<Squad>> getApprovedSquads();
  Future<int> get membersCount;

  Stream<bool?> streamMerlinKilled();
  Future<void> updateMerlinKilled(bool merlinKilled);

  Future<List<bool>> questVotesInfo(int questNumber);
}
