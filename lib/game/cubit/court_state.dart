part of 'court_cubit.dart';

class CourtState extends Equatable {
  final int rejectionsLeftToEvilWin;
  final int requiredPlayersNumber;
  final List<Courtier> courtiers;

  const CourtState({
    this.rejectionsLeftToEvilWin = 0,
    this.requiredPlayersNumber = 0,
    this.courtiers = const [],
  });

  @override
  List<Object?> get props =>
      [rejectionsLeftToEvilWin, requiredPlayersNumber, courtiers];

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
        rejectionsLeftToEvilWin: squad.rejectionsLeftToEvilWin,
        requiredPlayersNumber: squad.requiredPlayersNumber,
        courtiers: courtiers);
  }
}
