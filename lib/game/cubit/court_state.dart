part of 'court_cubit.dart';

class CourtState extends Equatable {
  final int squadId;
  final int prevRejectionCount;
  final int requiredMembersNumber;
  final int membersCount;
  final SquadStatus squadStatus;
  final List<Courtier> courtiers;
  final bool isLeader;
  bool get isSquadFull => membersCount == requiredMembersNumber;

  const CourtState({
    this.squadId = -1,
    this.prevRejectionCount = 0,
    this.requiredMembersNumber = 0,
    this.membersCount = 0,
    this.squadStatus = SquadStatus.unknown,
    this.courtiers = const [],
    this.isLeader = false,
  });

  @override
  List<Object?> get props => [
        squadId,
        prevRejectionCount,
        requiredMembersNumber,
        membersCount,
        squadStatus,
        courtiers,
        isLeader,
      ];

  CourtState from({
    required List<Player> players,
    required Squad squad,
    required int currentPlayerId,
  }) {
    List<Courtier> courtiers = players
        .map((p) => Courtier(
              playerId: p.playerId,
              nick: p.nick,
              isCurrentPlayer: p.playerId == currentPlayerId,
              isLeader: p.playerId == squad.leader.playerId,
              isMember: squad.members.any((m) => m.playerId == p.playerId),
            ))
        .toList();

    return CourtState(
      squadId: squad.squadId,
      prevRejectionCount: squad.prevRejectionCount,
      requiredMembersNumber: squad.requiredMembersNumber,
      membersCount: squad.members.length,
      squadStatus: squad.status,
      courtiers: courtiers,
      isLeader: kDebugMode || (squad.leader.playerId == currentPlayerId),
    );
  }
}
