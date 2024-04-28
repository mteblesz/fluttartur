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

  Future<void> addMember({required int playerId}) async {
    if (!state.isLeader) return;
    if (state.squadStatus != SquadStatus.squadChoice) return;
    if (state.membersCount >= state.requiredMembersNumber) return;

    await _dataRepository.addMember(playerId: playerId);
  }

  Future<void> removeMember({required int playerId}) async {
    if (!state.isLeader) return;
    if (state.squadStatus != SquadStatus.squadChoice) return;
    if (state.membersCount <= 0) return;

    await _dataRepository.removeMember(playerIdOfMember: playerId);
  }

  Future<void> submitSquad() async {
    if (!state.isLeader) return;
    if (state.membersCount != state.requiredMembersNumber) return;

    await _dataRepository.submitSquad(squadId: state.squadId);
  }

  Future<void> voteSquad(bool vote) async {
    await _dataRepository.voteSquad(vote);
  }
}
