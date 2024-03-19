import 'package:data_repository/src/dtos/dtos.dart';

import '../../model/model.dart';

class QuestInfoDto {
  int squadId;
  int questNumber;
  int squadNumber;
  int requiredPlayersNumber;
  SquadStatus status;
  PlayerInfoDto leader;
  List<PlayerInfoDto> members;
  List<VoteInfoDto> squadVoteInfo;
  int? questVoteSuccessCount;

  QuestInfoDto({
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

  factory QuestInfoDto.fromJson(Map<String, dynamic> json) {
    return QuestInfoDto(
      squadId: json['squadId'],
      questNumber: json['questNumber'],
      squadNumber: json['squadNumber'],
      requiredPlayersNumber: json['requiredPlayersNumber'],
      status: SquadStatus.values[json['status']],
      leader: PlayerInfoDto.fromJson(json['leader']),
      members: (json['members'] as List)
          .map((e) => PlayerInfoDto.fromJson(e))
          .toList(),
      squadVoteInfo: (json['squadVoteInfo'] as List)
          .map((e) => VoteInfoDto.fromJson(e))
          .toList(),
      questVoteSuccessCount: json['questVoteSuccessCount'],
    );
  }

  QuestInfo toQuestInfo() {
    return QuestInfo(
      squadId: squadId,
      questNumber: questNumber,
      squadNumber: squadNumber,
      requiredPlayersNumber: requiredPlayersNumber,
      status: SquadQuestStatusMapping.map(status),
      leader: leader.toPlayer(),
      members: members.map((member) => member.toPlayer()).toList(),
      squadVoteInfo:
          squadVoteInfo.map((voteInfo) => voteInfo.toVoteInfo()).toList(),
      questVoteSuccessCount: questVoteSuccessCount,
    );
  }
}
