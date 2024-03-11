import 'package:data_repository/model/model.dart';

class QuestInfo {
  final String squadId;
  final int questNumber;
  final int squadNumber;
  final int requiredPlayersNumber;
  final QuestStatus status;
  final Player leader;
  final List<Player> members;
  final List<VoteInfo> squadVoteInfo;

  /// May be null as this class might represent quad that did not get voted to a quest
  final int? questVoteSuccessCount;

  const QuestInfo({
    required this.squadId,
    required this.questNumber,
    required this.squadNumber,
    required this.requiredPlayersNumber,
    required this.status,
    required this.leader,
    required this.members,
    required this.squadVoteInfo,
    this.questVoteSuccessCount,
  });
}
