import 'package:equatable/equatable.dart';

import 'enums.dart';

class QuestInfoShort extends Equatable {
  final int? squadId;
  final int questNumber;
  final int requiredMembersNumber;
  final bool isDoubleFail;
  final QuestStatus status;

  const QuestInfoShort({
    this.squadId,
    required this.questNumber,
    required this.requiredMembersNumber,
    required this.isDoubleFail,
    required this.status,
  });

  @override
  List<Object?> get props =>
      [squadId, questNumber, requiredMembersNumber, isDoubleFail, status];
}
