import 'dart:async';
import 'package:data_repository/models/models.dart';

abstract class IDataRepository {
  Future<void> createRoom();
  Future<RoomInfoDto> getRoomById();

  // TODO old stuff for backwards-compatibility during changes (to be removed)

  Room get currentRoom;
  Stream<Room> streamRoom();
  Future<void> joinRoom();
  Future<void> startGame();
  void subscribeGameStartedWith({required void Function(bool) doLogic});
  void unsubscribeGameStarted();

  Player get currentPlayer;
  Stream<Player> streamPlayer();
  Future<void> addPlayer({
    required String userId,
    required String nick,
    bool isLeader = false,
  });
  Future<void> leaveRoom();

  Stream<List<Player>> streamPlayersList();
  Future<List<Player>> playersList();
  Future<int> get playersCount;

  Future<void> assignCharacters(List<String> characters);
  Future<void> assignSpecialCharacters(Map<String, Player> map);
  Future<void> assignLeader(int leaderIndex);
  Future<void> nextLeader();
  Future<void> removePlayer({required String playerId});

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

  StreamSubscription? _squadIsSubmittedSubscription;
  void subscribeSquadIsSubmittedWith({
    String squadId = '',
    required void Function(Squad) doLogic,
  });
  void unsubscribeSquadIsSubmitted();

  StreamSubscription? _currentSquadIdSubscription;
  String currentSquadId = "";
  void subscribeCurrentSquadIdWith({
    required void Function(String) doLogic,
  });
  void unsubscribeCurrentSquadId();
  Stream<String> streamCurrentSquadId();

  voteSquad(bool vote);
  StreamSubscription? _squadVotesSubscription;
  void subscribeSquadVotesWith({
    required void Function(Map<String, bool>) doLogic,
  });
  void unsubscribeSquadVotes();

  Future<String?> _getMemberIdWith({required Player player});

  Future<bool> isCurrentPlayerAMember();
  Future<void> voteQuest(bool vote);
  StreamSubscription? _questVotesSubscription;
  void subscribeQuestVotesWith({
    required void Function(List<bool?>) doLogic,
  });
  void unsubscribeQuestVotes();
  Future<void> updateSquadIsSuccessfull({bool isSuccessfull = true});

  Future<List<Squad>> getApprovedSquads();
  Future<int> get membersCount;

  Future<List<String>> getSpecialCharacters();
  Future<void> setSpecialCharacters(List<String> specialCharacters);

  Stream<bool?> streamMerlinKilled();
  Future<void> updateMerlinKilled(bool merlinKilled);

  Future<List<bool>> questVotesInfo(int questNumber);
}
