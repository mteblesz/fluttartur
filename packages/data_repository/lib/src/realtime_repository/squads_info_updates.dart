part of 'rtu_repository.dart';

extension SquadsInfoUpdates on RtuRepository {
  void subscribeCurrentSquad() {
    hubConnection.on(RtuConfig.ReceiveCurrentSquad, (List<Object?>? args) {
      if (args != null && args.isNotEmpty && args[0] is Map<String, dynamic>) {
        final dto = SquadInfoDto.fromJson(args[0] as Map<String, dynamic>);
        final squadInfo = dto.toSquad();
        _currentSquadStreamController.add(squadInfo);
      }
    });
  }

  void unsubscribeCurrentSquad() {
    hubConnection.off(RtuConfig.ReceiveCurrentSquad);
    _currentSquadStreamController.close();
  }

  // SQUADS

  void subscribeQuestsSummary() {
    hubConnection.on(RtuConfig.ReceiveQuestsSummary, (List<Object?>? args) {
      if (args != null && args.isNotEmpty && args[0] is List) {
        final data = args[0] as List<dynamic>;
        final dtos = data.map((data) => QuestInfoShortDto.fromJson(data));
        final questSummary = dtos.map((e) => e.toQuestInfoShort()).toList();
        if (questSummary.length != 5) {
          throw Exception('Invalid number of quests in summary');
        }
        _questsSummaryStreamController.add(questSummary);
      }
    });
  }

  void unsubscribeQuestsSummary() {
    hubConnection.off(RtuConfig.ReceiveQuestsSummary);
    _questsSummaryStreamController.close();
  }
}
