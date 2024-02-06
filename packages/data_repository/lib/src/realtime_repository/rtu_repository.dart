import 'dart:async';
import 'package:data_repository/src/data_cache.dart';
import 'package:data_repository/src/realtime_repository/rtu_config.dart';
import 'package:signalr_client/signalr_client.dart';
import '../../models/models.dart';
import 'package:logging/logging.dart';

class RtuRepository {
  RtuRepository(this._cache) {
    final serverUrl = RtuConfig.rtuUrl;

    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
    hubConnection = HubConnectionBuilder()
        .withUrl(serverUrl)
        .configureLogging(Logger("teblesz_logger"))
        .build();
  }

  final DataCache _cache;
  late HubConnection hubConnection;
  late StreamController<List<PlayerInfoDto>> _playerStreamController;

  Future<void> connect() async {
    try {
      await hubConnection.start();
    } on Exception catch (e) {
      print(e);
    }
  }

  void listenPlayers() {
    _playerStreamController = StreamController<List<PlayerInfoDto>>.broadcast();
    hubConnection.on("ReceivePlayerList", (arguments) {
      final updatedPlayerList = List<PlayerInfoDto>.from(arguments![0] as List);
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
