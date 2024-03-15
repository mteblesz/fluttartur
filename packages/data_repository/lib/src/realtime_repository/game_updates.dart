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
}
