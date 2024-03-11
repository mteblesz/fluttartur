import '../../model/model.dart';

class QuestInfoShortDto {
  int? squadId;
  int questNumber;
  int requiredPlayersNumber;
  bool isDoubleFail;
  SquadStatus status;

  QuestInfoShortDto({
    this.squadId,
    required this.questNumber,
    required this.requiredPlayersNumber,
    required this.isDoubleFail,
    required this.status,
  });

  factory QuestInfoShortDto.fromJson(Map<String, dynamic> json) {
    return QuestInfoShortDto(
      squadId: json['squadId'],
      questNumber: json['questNumber'],
      requiredPlayersNumber: json['requiredPlayersNumber'],
      isDoubleFail: json['isDoubleFail'],
      status: SquadStatus.values[json['status']],
    );
  }

  QuestInfoShort toQuestInfoShort() {
    return QuestInfoShort(
      squadId: squadId,
      questNumber: questNumber,
      requiredPlayersNumber: requiredPlayersNumber,
      isDoubleFail: isDoubleFail,
      status: SquadQuestStatusMapping.map(status),
    );
  }
}
