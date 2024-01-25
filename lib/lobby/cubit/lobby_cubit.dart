import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:data_repository/data_repository.dart';

part 'lobby_state.dart';

class LobbyCubit extends Cubit<LobbyState> {
  LobbyCubit(this._dataRepository) : super(const LobbyState());

  final IDataRepository _dataRepository;

  void roomIdChanged(String value) {
    final roomId = RoomId.dirty(value);
    emit(
      state.copyWith(
        roomId: roomId,
        statusOfJoin: Formz.validate([roomId]),
      ),
    );
  }

  Future<void> joinRoom() async {
    if (!state.statusOfJoin.isValidated) return;
    emit(state.copyWith(statusOfJoin: FormzStatus.submissionInProgress));
    try {
      await _dataRepository.joinRoom(roomId: int.parse(state.roomId.value));
      emit(state.copyWith(statusOfJoin: FormzStatus.submissionSuccess));
    } on DataRepoFailure catch (e) {
      emit(state.copyWith(
        statusOfJoin: FormzStatus.submissionFailure,
        errorMessage: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(statusOfJoin: FormzStatus.submissionFailure));
    }
  }

  Future<void> createRoom() async {
    emit(state.copyWith(statusOfCreate: FormzStatus.submissionInProgress));
    try {
      await _dataRepository.createRoom();
      emit(state.copyWith(statusOfCreate: FormzStatus.submissionSuccess));
    } on DataRepoFailure catch (e) {
      emit(state.copyWith(
        statusOfJoin: FormzStatus.submissionFailure,
        errorMessage: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(statusOfCreate: FormzStatus.submissionFailure));
    }
  }

  void resetButtonsState() {
    emit(state.copyWith(statusOfCreate: FormzStatus.pure));
    emit(state.copyWith(statusOfJoin: FormzStatus.pure));
  }
}
