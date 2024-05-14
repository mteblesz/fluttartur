part of 'rtu_repository.dart';

extension GameUpdates on RtuRepository {
  void handlePlayerLeftGame({
    required void Function(Player) playerLeftHandler,
  }) {
    hubConnection.on(RtuConfig.ReceivePlayerLeft, (List<Object?>? args) {
      if (args != null && args.isNotEmpty) {
        final data = args[0] as Map<String, dynamic>;
        final dto = PlayerInfoDto.fromJson(data);
        hubConnection.off(RtuConfig.ReceiveRemoval);
        playerLeftHandler(dto.toPlayer());
      }
    });
  }

  void subscribeEndGameInfo() {
    _endGameInfoStreamController.close();
    _endGameInfoStreamController = StreamController<RoomStatus>();
    hubConnection.on(RtuConfig.ReceiveEndGameInfo, (List<Object?>? args) {
      if (args != null && args.isNotEmpty && args[0] is Map<String, dynamic>) {
        final dto = EndGameInfoDto.fromJson(args[0] as Map<String, dynamic>);
        final roomStatus = dto.status;
        _endGameInfoStreamController.add(roomStatus);
      }
    });
  }

  void unsubscribeEndGameInfo() {
    hubConnection.off(RtuConfig.ReceiveEndGameInfo);
    _endGameInfoStreamController.close();
  }
}
