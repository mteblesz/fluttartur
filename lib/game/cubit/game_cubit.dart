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

  //-------------------------merlin killing logic------------------------

  bool assassinPresent() => false;
  //_dataRepository.currentRoom.specialCharacters.contains("evil_assassin");

  bool isAssassin() => false;
  //_dataRepository.currentPlayer.role == "evil_assassin";

  Stream<bool?> streamMerlinKilled() {
    return _dataRepository.streamMerlinKilled();
  }

  Future<void> killPlayer({required Player player}) async {
    //await _dataRepository.updateMerlinKilled(player.role == "good_merlin");
  }
}
