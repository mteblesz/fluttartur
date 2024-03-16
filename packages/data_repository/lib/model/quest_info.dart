import 'package:data_repository/model/model.dart';

class QuestInfo {
  final int squadId;
  final int questNumber;
  final int squadNumber;
  final int requiredPlayersNumber;
  final QuestStatus status;
  final Player leader;
  final List<Player> members;
  final List<VoteInfo> squadVoteInfo;

  /// May be null as this class might represent squad that did not get voted to a quest
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

  int get totalPlayers => members.length;
  static QuestInfo get empty {
    return const QuestInfo(
      squadId: 0,
      questNumber: 0,
      squadNumber: 0,
      requiredPlayersNumber: 0,
      status: QuestStatus.error,
      leader: Player.empty,
      members: [],
      squadVoteInfo: [],
      questVoteSuccessCount: null,
    );
  }

  bool get isEmpty => this == QuestInfo.empty;

  bool get isNotEmpty => this != QuestInfo.empty;
}
