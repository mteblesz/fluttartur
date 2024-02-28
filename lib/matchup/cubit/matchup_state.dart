part of 'matchup_cubit.dart';

// TODO add error messages in cubits
class MatchupState extends Equatable {
  const MatchupState({
    this.nick = const Nick.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.playersCount = 0,
    this.isHost = false,
    this.areMerlinAndAssassinInGame = false,
    this.arePercivalAreMorganaInGame = false,
    this.areOberonAndMordredInGame = false,
  });

  final Nick nick;
  final FormzStatus status;
  final String? errorMessage;
  final int playersCount;
  final bool isHost;
  final bool areMerlinAndAssassinInGame;
  final bool arePercivalAreMorganaInGame;
  final bool areOberonAndMordredInGame;

  @override
  List<Object> get props => [
        nick,
        status,
        playersCount,
        isHost,
        areMerlinAndAssassinInGame,
        arePercivalAreMorganaInGame,
        areOberonAndMordredInGame,
      ];

  MatchupState copyWith({
    Nick? nick,
    FormzStatus? status,
    String? errorMessage,
    int? playersCount,
    bool? isHost,
    bool? areMerlinAndAssassinInGame,
    bool? arePercivalAreMorganaInGame,
    bool? areOberonAndMordredInGame,
  }) {
    return MatchupState(
      nick: nick ?? this.nick,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      playersCount: playersCount ?? this.playersCount,
      isHost: isHost ?? this.isHost,
      areMerlinAndAssassinInGame:
          areMerlinAndAssassinInGame ?? this.areMerlinAndAssassinInGame,
      arePercivalAreMorganaInGame:
          arePercivalAreMorganaInGame ?? this.arePercivalAreMorganaInGame,
      areOberonAndMordredInGame:
          areOberonAndMordredInGame ?? this.areOberonAndMordredInGame,
    );
  }
}
