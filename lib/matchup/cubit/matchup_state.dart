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

// needs to be in one object for blockbuilder
class RolesDef extends Equatable {
  const RolesDef({
    this.hasMerlinAndAssassin = false,
    this.hasPercivalAndMorgana = false,
    this.hasOberonAndMordred = false,
  });
  final bool hasMerlinAndAssassin;
  final bool hasPercivalAndMorgana;
  final bool hasOberonAndMordred;

  @override
  List<Object?> get props => [
        hasMerlinAndAssassin,
        hasPercivalAndMorgana,
        hasOberonAndMordred,
      ];

  RolesDef copyWith(
    bool? hasMerlinAndAssassin,
    bool? hasPercivalAndMorgana,
    bool? hasOberonAndMordred,
  ) {
    return RolesDef(
      hasMerlinAndAssassin: hasMerlinAndAssassin ?? this.hasMerlinAndAssassin,
      hasPercivalAndMorgana:
          hasPercivalAndMorgana ?? this.hasPercivalAndMorgana,
      hasOberonAndMordred: hasOberonAndMordred ?? this.hasOberonAndMordred,
    );
  }
}
