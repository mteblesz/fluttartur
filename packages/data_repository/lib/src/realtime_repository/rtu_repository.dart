import 'dart:async';
import 'package:data_repository/src/realtime_repository/rtu_config.dart';
import '../dtos/dtos.dart';
import '../../model/model.dart';
import 'package:signalr_netcore/signalr_client.dart';

class RtuRepository {
  RtuRepository() {
    final serverUrl = RtuConfig.url;
    hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
    hubConnection.onclose(({error}) {
      print("Connection Closed");
    });
  }

  late HubConnection hubConnection;

  Future<void> connect({required int roomId}) async {
    await hubConnection.start();
    await hubConnection.invoke(
      "JoinRoomGroup",
      args: [roomId.toString()],
    );
  }

  void dispose() {
    hubConnection.stop();
  }

  late StreamController<List<Player>> _playerStreamController;
  Stream<List<Player>> get playerStream => _playerStreamController.stream;

  void subscribePlayersList() {
    _playerStreamController = StreamController<List<Player>>.broadcast();
    hubConnection.on("ReceivePlayerList", (List<Object?>? args) {
      if (args != null && args.isNotEmpty && args[0] is List) {
        final data = args[0] as List<dynamic>;
        final dtos = data.map((data) => PlayerInfoDto.fromJson(data));
        final updatedPlayers = dtos.map((e) => e.toPLayer()).toList();
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
