part of 'rtu_repository.dart';

extension SquadsInfoUpdates on RtuRepository {
  void subscribeCurrentSquad() {
    _currentSquadStreamController = StreamController<Squad>.broadcast();
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
    _questsSummaryStreamController =
        StreamController<List<QuestInfoShort>>.broadcast();
    hubConnection.on(RtuConfig.ReceiveQuestsSummary, (List<Object?>? args) {
      if (args != null && args.isNotEmpty && args[0] is List) {
        final data = args[0] as List<dynamic>;
        final dtos = data.map((data) => QuestInfoShortDto.fromJson(data));
        final questSummaryList = dtos.map((e) => e.toQuestInfoShort()).toList();
        _questsSummaryStreamController.add(questSummaryList);
      }
    });
  }

  void unsubscribeQuestsSummary() {
    hubConnection.off(RtuConfig.ReceiveQuestsSummary);
    _questsSummaryStreamController.close();
  }
}
