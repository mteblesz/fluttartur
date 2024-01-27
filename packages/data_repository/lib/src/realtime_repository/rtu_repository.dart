import 'dart:async';
import 'package:data_repository/src/data_cache.dart';
import 'package:data_repository/src/realtime_repository/rtu_config.dart';
import 'package:signalr_netcore/signalr_client.dart';
import '../../models/models.dart';

class RtuRepository {
  RtuRepository(this._cache) {
    final serverUrl = RtuConfig.rtuUrl;
    hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
  }

  final DataCache _cache;
  late HubConnection hubConnection;
  late StreamController<List<PlayerInfoDto>> _playerStreamController;

  void connect() {
    hubConnection.start();
  }

  void listenPlayers() {
    _playerStreamController = StreamController<List<PlayerInfoDto>>.broadcast();
    hubConnection.on("ReceivePlayerList", (arguments) {
      final updatedPlayerList = List<PlayerInfoDto>.from(arguments![0]);
      _playerStreamController.add(updatedPlayerList);
    });
  }

  Stream<List<PlayerInfoDto>> get playerStream =>
      _playerStreamController.stream;

  void dispose() {
    _playerStreamController.close();
    hubConnection.stop();
  }
}
