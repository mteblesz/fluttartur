import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'nick_form_state.dart';

class NickFormCubit extends Cubit<NickFormState> {
  NickFormCubit(this._dataRepository) : super(const NickFormState());

  final IDataRepository _dataRepository;

  void nickChanged(String value) {
    value = value.trim();
    final nick = Nick.dirty(value);
    emit(state.copyWith(nick: nick, status: Formz.validate([nick])));
  }

  Future<void> setNickname(String userId) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _dataRepository.setNickname(
        nick: state.nick.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
