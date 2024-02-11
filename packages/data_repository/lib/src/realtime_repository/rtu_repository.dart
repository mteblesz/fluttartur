import 'dart:async';
import 'package:data_repository/src/data_cache.dart';
import 'package:data_repository/src/realtime_repository/rtu_config.dart';
import '../../models/models.dart';

class RtuRepository {
  RtuRepository(this._cache) {
    final serverUrl = RtuConfig.rtuUrl;
  }

  final DataCache _cache;
  late StreamController<List<PlayerInfoDto>> _playerStreamController;

  Future<void> connect() async {}

  void listenPlayers() {
    _playerStreamController = StreamController<List<PlayerInfoDto>>.broadcast();
    //on("ReceivePlayerList", (arguments) {
    //  final updatedPlayerList = List<PlayerInfoDto>.from(arguments![0] as List);
    //   _playerStreamController.add(updatedPlayerList);
    //});
  }

  Stream<List<PlayerInfoDto>> get playerStream =>
      _playerStreamController.stream;

  void dispose() {
    _playerStreamController.close();
    // hubConnection.stop();
  }
}
