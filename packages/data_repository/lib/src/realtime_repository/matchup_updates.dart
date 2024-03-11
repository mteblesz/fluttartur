part of 'rtu_repository.dart';

extension SquadsInfoUpdates on RtuRepository {
  void subscribePlayersList() {
    _playerStreamController = StreamController<List<Player>>.broadcast();
    hubConnection.on("ReceivePlayerList", (List<Object?>? args) {
      if (args != null && args.isNotEmpty && args[0] is List) {
        final data = args[0] as List<dynamic>;
        final dtos = data.map((data) => PlayerInfoDto.fromJson(data));
        final updatedPlayers = dtos.map((e) => e.toPlayer()).toList();
        _playerStreamController.add(updatedPlayers);
      }
    });
  }

  void unsubscribePlayersList() {
    hubConnection.off("ReceivePlayerList");
    _playerStreamController.close();
  }

  void handlePlayerRemoval({
    required int playerId,
    required void Function() removalHandler,
  }) {
    hubConnection.on("ReceiveRemoval", (List<Object?>? args) {
      if (args != null && args.isNotEmpty) {
        final removedplayerId = args[0] as String;
        if (removedplayerId == playerId.toString()) {
          hubConnection.off("ReceiveRemoval");
          removalHandler();
          dispose();
        }
      }
    });
  }

  void handleGameStarted({required void Function() startGameHandler}) {
    hubConnection.on("ReceiveStartGame", (List<Object?>? args) {
      hubConnection.off("ReceiveStartGame");
      startGameHandler();
    });
  }
}
