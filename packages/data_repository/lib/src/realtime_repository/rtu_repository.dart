import 'dart:async';
import 'package:data_repository/src/data_cache.dart';
import 'package:data_repository/src/realtime_repository/rtu_config.dart';
import '../../dtos/dtos.dart';
import '../../models/models.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class RtuRepository {
  RtuRepository(this._cache) {}

  final DataCache _cache;
  late WebSocketChannel _channel;

  Future<void> connect() async {
    try {
      final wsUri = Uri.parse(RtuConfig.wsUrl);
      _channel = WebSocketChannel.connect(wsUri);
      await _channel.ready;
    } on Exception catch (_) {
      // TODO logging
      rethrow;
    }
  }

  void dispose() {
    try {
      _playerStreamController.close();
      _channel.sink.close();
    } on Exception catch (_) {
      // TODO logging
      rethrow;
    }
  }

  late StreamController<List<Player>> _playerStreamController;
  Stream<List<Player>> get playerStream => _playerStreamController.stream;

  void listenPlayers() {
    _playerStreamController = StreamController<List<Player>>.broadcast();
    _channel.stream.listen((message) {
      final dtos = List<PlayerInfoDto>.from(message as List);
      Iterable<Player> updatedPlayerList = dtos.map((e) => e.toPLayer());
      _playerStreamController.add(updatedPlayerList.toList());
    });
  }
}
