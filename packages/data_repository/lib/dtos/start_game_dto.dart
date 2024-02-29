import '../models/models.dart';

class StartGameDto {
  int roomId;
  bool areMerlinAndAssassinInGame;
  bool arePercivalAndMorganaInGame;
  bool areOberonAndMordredInGame;

  StartGameDto({
    required this.roomId,
    required this.areMerlinAndAssassinInGame,
    required this.arePercivalAndMorganaInGame,
    required this.areOberonAndMordredInGame,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      'areMerlinAndAssassinInGame': areMerlinAndAssassinInGame,
      'arePercivalAndMorganaInGame': arePercivalAndMorganaInGame,
      'areOberonAndMordredInGame': areOberonAndMordredInGame,
    };
  }

  factory StartGameDto.fromRolesDef(int roomId, RolesDef rolesDef) {
    return StartGameDto(
      roomId: roomId,
      areMerlinAndAssassinInGame: rolesDef.hasMerlinAndAssassin,
      arePercivalAndMorganaInGame: rolesDef.hasPercivalAndMorgana,
      areOberonAndMordredInGame: rolesDef.hasOberonAndMordred,
    );
  }
}
