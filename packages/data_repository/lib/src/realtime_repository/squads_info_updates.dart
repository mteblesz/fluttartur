part of 'rtu_repository.dart';

extension SquadsInfoUpdates on RtuRepository {
  void subscribeCurrentSquad() {
    _currentSquadStreamController = StreamController<SquadInfoDto>.broadcast();
    hubConnection.on("ReceiveCurrentSquad", (List<Object?>? args) {
      if (args != null && args.isNotEmpty && args[0] is Map<String, dynamic>) {
        final squadInfo =
            SquadInfoDto.fromJson(args[0] as Map<String, dynamic>);
        _currentSquadStreamController.add(squadInfo);
      }
    });
  }

  void unsubscribeCurrentSquad() {
    hubConnection.off("ReceiveCurrentSquad");
    _currentSquadStreamController.close();
  }

  // SQUADS

  void subscribeSquadList() {
    _questsSummaryStreamController =
        StreamController<List<QuestInfoShortDto>>.broadcast();
    hubConnection.on("ReceiveSquadsSummary", (List<Object?>? args) {
      if (args != null && args.isNotEmpty && args[0] is List) {
        final questSummaryList = (args[0] as List)
            .map((e) => QuestInfoShortDto.fromJson(e as Map<String, dynamic>))
            .toList();
        _questsSummaryStreamController.add(questSummaryList);
      }
    });
  }

  void unsubscribeSquadList() {
    hubConnection.off("ReceiveSquadsSummary");
    _questsSummaryStreamController.close();
  }
}
