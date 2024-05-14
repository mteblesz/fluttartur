import 'dart:async';
import 'package:data_repository/src/realtime_repository/config.dart';
import '../dtos/dtos.dart';
import '../../model/model.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:rxdart/rxdart.dart';

part 'squads_info_updates.dart';
part 'matchup_updates.dart';
part 'game_updates.dart';

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
      RtuConfig.JoinRoomGroup,
      args: [roomId.toString()],
    );
  }

  void dispose() {
    hubConnection.stop();
  }

  // https://stackoverflow.com/a/56279276/23287406
  BehaviorSubject<List<Player>> _playerStreamController =
      BehaviorSubject<List<Player>>();
  Sink<List<Player>> get _playerStreamSink => _playerStreamController.sink;
  Stream<List<Player>> get playerStream => _playerStreamController.stream;

  StreamController<Squad> _currentSquadStreamController =
      StreamController<Squad>();
  Stream<Squad> get currentSquadStream => _currentSquadStreamController.stream;

  StreamController<List<QuestInfoShort>> _questsSummaryStreamController =
      StreamController<List<QuestInfoShort>>();
  Stream<List<QuestInfoShort>> get questsSummaryStream =>
      _questsSummaryStreamController.stream;

  StreamController<RoomStatus> _endGameInfoStreamController =
      StreamController<RoomStatus>();
  Stream<RoomStatus> get endGameInfoStream =>
      _endGameInfoStreamController.stream;
}
