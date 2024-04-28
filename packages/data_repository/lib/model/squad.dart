import 'package:equatable/equatable.dart';

import 'enums.dart';
import 'player.dart';

class Squad extends Equatable {
  final int squadId;
  final int questNumber;
  final int prevRejectionCount;
  final int requiredMembersNumber;
  final SquadStatus status;
  final Player leader;
  final List<Player> members;

  const Squad({
    required this.squadId,
    required this.questNumber,
    required this.prevRejectionCount,
    required this.requiredMembersNumber,
    required this.status,
    required this.leader,
    required this.members,
  });

  /// Empty Squad
  static const empty = Squad(
    squadId: -1,
    questNumber: 0,
    prevRejectionCount: 0,
    requiredMembersNumber: 0,
    status: SquadStatus.unknown,
    leader: Player.empty,
    members: [],
  );
  bool get isEmpty => this == Squad.empty;
  bool get isNotEmpty => this != Squad.empty;

  @override
  List<Object?> get props => [
        squadId,
        questNumber,
        prevRejectionCount,
        requiredMembersNumber,
        status,
        leader,
        members,
      ];

  bool get isUnknown => status == SquadStatus.unknown;
  bool get isUpcoming => status == SquadStatus.upcoming;
  bool get isSquadChoice => status == SquadStatus.squadChoice;
  bool get isSubmitted => status == SquadStatus.submitted;
  bool get isApproved => status == SquadStatus.approved;
  bool get isRejected => status == SquadStatus.rejected;
  bool get isQuestVoting => status == SquadStatus.questVoting;
  bool get isSuccessful => status == SquadStatus.successful;
  bool get isFailed => status == SquadStatus.failed;
  bool get isError => status == SquadStatus.error;
}
