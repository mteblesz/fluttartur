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

  void start() {
    hubConnection.start();
  }

  void listenPLayers() {
    _playerStreamController = StreamController<List<PlayerInfoDto>>.broadcast();
    listenPlayers();
  }

  Stream<List<PlayerInfoDto>> get playerStream =>
      _playerStreamController.stream;

  void listenPlayers() {
    hubConnection.on("ReceivePlayerList", (arguments) {
      List<PlayerInfoDto> updatedPlayerList = processData(arguments![0]);
      _playerStreamController.add(updatedPlayerList);
    });
  }

  List<PlayerInfoDto> processData(dynamic data) {
    return List<PlayerInfoDto>.from(data);
  }

  void dispose() {
    _playerStreamController.close();
    hubConnection.stop();
  }
}
