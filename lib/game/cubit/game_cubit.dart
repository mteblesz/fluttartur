import 'package:data_repository/data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final IDataRepository _dataRepository;

  GameCubit(this._dataRepository) : super(const GameState()) {
    _dataRepository.streamEndGameInfo().listen((status) {
      emit(state.copyWith(status: status));
    });
  }

  Future<List<Player>> getEvilPlayers() {
    return _dataRepository.getEvilPlayers();
  }

  Future<List<Player>> getMerlinAndMorgana() {
    return _dataRepository.getMerlinAndMorgana();
  }

  //------------------------- assassination ------------------------

  bool isAssassin() {
    return _dataRepository.currentTeamRole.role == Role.assassin;
  }

  Future<List<Player>> getGoodPlayers() {
    return _dataRepository.getGoodPlayers();
  }

  Future<void> killPlayer({required int playerId}) async {
    await _dataRepository.killPlayer(playerId: playerId);
  }
}
