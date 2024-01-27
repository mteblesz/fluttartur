import 'dart:async';
import 'package:signalr_netcore/signalr_client.dart';
import '../models/models.dart';
import 'api_config.dart';

class RealTimeUpdatesRepository {
  late HubConnection hubConnection;
  late StreamController<List<PlayerInfoDto>> _playerStreamController;

  RealTimeUpdatesRepository() {
    final serverUrl = ApiConfig.rtuUrl;
    hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();

    _playerStreamController = StreamController<List<PlayerInfoDto>>.broadcast();

    hubConnection.start();

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
