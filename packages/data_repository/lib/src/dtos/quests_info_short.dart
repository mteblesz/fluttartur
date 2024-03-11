import 'package:data_repository/model/enums.dart';

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

  Map<String, dynamic> toJson() {
    return {
      'squadId': squadId,
      'questNumber': questNumber,
      'requiredPlayersNumber': requiredPlayersNumber,
      'isDoubleFail': isDoubleFail,
      'status': status.index,
    };
  }
}
