part of 'matchup_cubit.dart';

class MatchupState extends Equatable {
  const MatchupState({
    this.playersCount = 0,
    this.statusOfStartGame = FormzStatus.pure,
    this.rolesDef = const RolesDef(),
    this.errorMessage = "",
  });

  final int playersCount;
  final RolesDef rolesDef;
  final FormzStatus statusOfStartGame;
  final String errorMessage;

  @override
  List<Object> get props => [
        playersCount,
        rolesDef,
        statusOfStartGame,
        errorMessage,
      ];

  MatchupState copyWith({
    bool? isHost,
    int? playersCount,
    bool? hasMerlinAndAssassin,
    bool? hasPercivalAndMorgana,
    bool? hasOberonAndMordred,
    FormzStatus? statusOfStartGame,
    String? errorMessage,
  }) {
    return MatchupState(
      playersCount: playersCount ?? this.playersCount,
      rolesDef: rolesDef.copyWith(
        hasMerlinAndAssassin,
        hasPercivalAndMorgana,
        hasOberonAndMordred,
      ),
      statusOfStartGame: statusOfStartGame ?? this.statusOfStartGame,
      errorMessage: errorMessage ?? "", // empty by default
    );
  }
}
