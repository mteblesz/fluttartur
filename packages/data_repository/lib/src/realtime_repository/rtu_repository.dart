import 'dart:async';
import 'package:data_repository/src/data_cache.dart';
import 'package:data_repository/src/realtime_repository/rtu_config.dart';
import '../../dtos/dtos.dart';
import '../../models/models.dart';
import 'package:signalr_netcore/signalr_client.dart';
//import 'package:web_socket_channel/status.dart' as status;

class RtuRepository {
  RtuRepository(this._cache) {
    final serverUrl = RtuConfig.url;
    hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
    hubConnection.onclose(({error}) {
      print("Connection Closed");
    });
  }

  final DataCache _cache;
  late HubConnection hubConnection;

  Future<void> connect() async {
    await hubConnection.start();
  }

  void dispose() {
    hubConnection.stop();
  }

  late StreamController<List<Player>> _playerStreamController;
  Stream<List<Player>> get playerStream => _playerStreamController.stream;

  void listenPlayers() {
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

  void stopListeningPlayers() {
    hubConnection.off("ReceivePlayerList");
    _playerStreamController.close();
  }
}
