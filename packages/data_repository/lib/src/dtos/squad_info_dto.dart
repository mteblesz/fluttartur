import '../../model/model.dart';
import 'player_info_dto.dart';

class SquadInfoDto {
  int squadId;
  int questNumber;
  int rejectionsLeftToEvilWin;
  int requiredMembersNumber;
  SquadStatus status;
  PlayerInfoDto leader;
  List<PlayerInfoDto> members;

  SquadInfoDto({
    required this.squadId,
    required this.questNumber,
    required this.rejectionsLeftToEvilWin,
    required this.requiredMembersNumber,
    required this.status,
    required this.leader,
    required this.members,
  });

  factory SquadInfoDto.fromJson(Map<String, dynamic> json) {
    return SquadInfoDto(
      squadId: json['squadId'],
      questNumber: json['questNumber'],
      rejectionsLeftToEvilWin: json['rejectionsLeftToEvilWin'],
      requiredMembersNumber: json['requiredMembersNumber'],
      status: SquadStatus.values[json['status']],
      leader: PlayerInfoDto.fromJson(json['leader']),
      members: (json['members'] as List)
          .map((e) => PlayerInfoDto.fromJson(e))
          .toList(),
    );
  }

  Squad toSquad() {
    return Squad(
      squadId: squadId,
      questNumber: questNumber,
      rejectionsLeftToEvilWin: rejectionsLeftToEvilWin,
      requiredMembersNumber: requiredMembersNumber,
      status: status,
      leader: leader.toPlayer(),
      members: members.map((member) => member.toPlayer()).toList(),
    );
  }
}
