part of 'matchup_cubit.dart';

class MatchupState extends Equatable {
  const MatchupState({
    this.playersCount = 0,
    this.rolesDef = const RolesDef(),
  });

  final int playersCount;
  final RolesDef rolesDef;

  @override
  List<Object> get props => [
        playersCount,
        rolesDef,
      ];

  MatchupState copyWith({
    bool? isHost,
    int? playersCount,
    bool? hasMerlinAndAssassin,
    bool? hasPercivalAndMorgana,
    bool? hasOberonAndMordred,
  }) {
    return MatchupState(
        playersCount: playersCount ?? this.playersCount,
        rolesDef: rolesDef.copyWith(
          hasMerlinAndAssassin,
          hasPercivalAndMorgana,
          hasOberonAndMordred,
        ));
  }
}
