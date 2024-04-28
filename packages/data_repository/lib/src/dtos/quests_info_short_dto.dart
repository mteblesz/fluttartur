import '../../model/model.dart';

class QuestInfoShortDto {
  int? squadId;
  int questNumber;
  int requiredMembersNumber;
  bool isDoubleFail;
  SquadStatus status;

  QuestInfoShortDto({
    this.squadId,
    required this.questNumber,
    required this.requiredMembersNumber,
    required this.isDoubleFail,
    required this.status,
  });

  factory QuestInfoShortDto.fromJson(Map<String, dynamic> json) {
    return QuestInfoShortDto(
      squadId: json['squadId'],
      questNumber: json['questNumber'],
      requiredMembersNumber: json['requiredMembersNumber'],
      isDoubleFail: json['isDoubleFail'],
      status: SquadStatus.values[json['status']],
    );
  }

  QuestInfoShort toQuestInfoShort() {
    return QuestInfoShort(
      squadId: squadId,
      questNumber: questNumber,
      requiredMembersNumber: requiredMembersNumber,
      isDoubleFail: isDoubleFail,
      status: SquadQuestStatusMapping.map(status),
    );
  }
}
