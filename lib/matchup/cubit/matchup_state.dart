part of 'matchup_cubit.dart';

// TODO add error messages in cubits
class MatchupState extends Equatable {
  const MatchupState({
    this.isHost = false,
    this.playersCount = 0,
    this.areMerlinAndAssassinInGame = false,
    this.arePercivalAreMorganaInGame = false,
    this.areOberonAndMordredInGame = false,
  });

  final bool isHost;
  final int playersCount;
  final bool areMerlinAndAssassinInGame;
  final bool arePercivalAreMorganaInGame;
  final bool areOberonAndMordredInGame;

  @override
  List<Object> get props => [
        isHost,
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
      isHost: isHost ?? this.isHost,
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
