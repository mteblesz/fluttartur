part of 'rtu_repository.dart';

extension MatchupUpdates on RtuRepository {
  void subscribePlayersList() {
    _playerStreamController = StreamController<List<Player>>.broadcast();
    hubConnection.on(RtuConfig.ReceivePlayerList, (List<Object?>? args) {
      if (args != null && args.isNotEmpty && args[0] is List) {
        final data = args[0] as List<dynamic>;
        final dtos = data.map((data) => PlayerInfoDto.fromJson(data));
        final updatedPlayers = dtos.map((e) => e.toPlayer()).toList();
        _playerStreamController.add(updatedPlayers);
      }
    });
  }

  void unsubscribePlayersList() {
    hubConnection.off(RtuConfig.ReceivePlayerList);
    _playerStreamController.close();
  }

  void handlePlayerRemoval({
    required int currentPlayerId,
    required void Function() removalHandler,
  }) {
    hubConnection.on(RtuConfig.ReceiveRemoval, (List<Object?>? args) {
      if (args != null && args.isNotEmpty) {
        final removedplayerId = args[0] as String;
        if (removedplayerId == currentPlayerId.toString()) {
          hubConnection.off(RtuConfig.ReceiveRemoval);
          removalHandler();
          dispose();
        }
      }
    });
  }

  void handleGameStarted({required void Function() startGameHandler}) {
    hubConnection.on(RtuConfig.ReceiveStartGame, (List<Object?>? args) {
      hubConnection.off(RtuConfig.ReceiveStartGame);
      startGameHandler();
    });
  }
}
