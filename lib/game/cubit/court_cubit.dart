import 'package:data_repository/data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttartur/game/model/courtier.dart';

part 'court_state.dart';

class CourtCubit extends Cubit<CourtState> {
  final IDataRepository _dataRepository;
  late List<Player> players;

  CourtCubit(this._dataRepository) : super(const CourtState()) {
    _init();
  }

  Future<void> _init() async {
    this.players = await _dataRepository.getPlayers();
    _dataRepository.streamCurrentSquad().listen((squad) {
      emit(state.from(
        players: players,
        squad: squad,
        currentPlayerId: _dataRepository.currentPlayerId,
      ));
    });
  }

  /// add player to squad
  Future<void> addMember({required int playerId}) async {
    //if (!_dataRepository.currentPlayer.isLeader) return;
    // if (state.status != GameStatus.squadChoice) return;

    // if (state.isSquadFull) return;

    // await _dataRepository.addMember(
    //   playerId: player.playerId,
    // );

    // final isSquadFull = true;
    // emit(state.copyWith(isSquadFull: isSquadFull));
  }

  /// remove player from squad
  Future<void> removeMember({required int playerId}) async {
    //if (!_dataRepository.currentPlayer.isLeader) return;
    //   if (state.status != GameStatus.squadChoice) return;

    //   await _dataRepository.removeMember(
    //     questNumber: state.questNumber,
    //     memberId: member.playerId,
    //   );

    //   emit(state.copyWith(isSquadFull: false));
  }

  Future<void> submitSquad() async {
    //   final isSquadRequiredSize = true;
    //   if (!isSquadRequiredSize) return;
    //   await _dataRepository.submitSquad();
  }

  bool squadFullSize(int playersCount, int questNumber) {
    return true; // TODO wrong wrong
  }

  bool isTwoFailsQuest(int playersCount, int questNumber) {
    return false; // TODO wrong wrong
  }
}
