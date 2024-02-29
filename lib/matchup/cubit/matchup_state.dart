part of 'matchup_cubit.dart';

class MatchupState extends Equatable {
  const MatchupState({
    this.playersCount = 0,
    this.areMerlinAndAssassinInGame = false,
    this.arePercivalAreMorganaInGame = false,
    this.areOberonAndMordredInGame = false,
  });

  final int playersCount;
  final bool areMerlinAndAssassinInGame;
  final bool arePercivalAreMorganaInGame;
  final bool areOberonAndMordredInGame;

  @override
  List<Object> get props => [
        playersCount,
        areMerlinAndAssassinInGame,
        arePercivalAreMorganaInGame,
        areOberonAndMordredInGame,
      ];

  MatchupState copyWith({
    bool? isHost,
    int? playersCount,
    bool? areMerlinAndAssassinInGame,
    bool? arePercivalAreMorganaInGame,
    bool? areOberonAndMordredInGame,
  }) {
    return MatchupState(
      playersCount: playersCount ?? this.playersCount,
      areMerlinAndAssassinInGame:
          areMerlinAndAssassinInGame ?? this.areMerlinAndAssassinInGame,
      arePercivalAreMorganaInGame:
          arePercivalAreMorganaInGame ?? this.arePercivalAreMorganaInGame,
      areOberonAndMordredInGame:
          areOberonAndMordredInGame ?? this.areOberonAndMordredInGame,
    );
  }
}
