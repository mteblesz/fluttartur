import 'package:equatable/equatable.dart';

import 'enums.dart';

class QuestInfoShort extends Equatable {
  final int? squadId;
  final int questNumber;
  final int requiredPlayersNumber;
  final bool isDoubleFail;
  final QuestStatus status;

  const QuestInfoShort({
    this.squadId,
    required this.questNumber,
    required this.requiredPlayersNumber,
    required this.isDoubleFail,
    required this.status,
  });

  @override
  List<Object?> get props =>
      [squadId, questNumber, requiredPlayersNumber, isDoubleFail, status];
}
