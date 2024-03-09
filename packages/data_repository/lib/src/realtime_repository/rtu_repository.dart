import 'dart:async';
import 'package:data_repository/src/realtime_repository/rtu_config.dart';
import '../dtos/dtos.dart';
import '../../model/model.dart';
import 'package:signalr_netcore/signalr_client.dart';

part 'squads_info_updates.dart';
part 'matchup_updates.dart';

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
}
