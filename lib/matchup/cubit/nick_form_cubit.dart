import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'nick_form_state.dart';

class NickFormCubit extends Cubit<NickFormState> {
  NickFormCubit(this._dataRepository, this._localizations)
      : super(const NickFormState());

  final IDataRepository _dataRepository;
  final AppLocalizations _localizations;

  void nickChanged(String value) {
    value = value.trim();
    final nick = Nick.dirty(value);
    final nickStatus = Formz.validate([nick]);

    String? errorMessage;
    switch (nick.error) {
      case NickValidationError.invalid:
        errorMessage = _localizations.nickInvalid;
        break;
      case NickValidationError.tooShort:
        errorMessage = _localizations.nickTooShort;
        break;
      case NickValidationError.tooLong:
        errorMessage = _localizations.nickTooLong;
        break;
      case NickValidationError.invalidCharacters:
        errorMessage = _localizations.nickHasINvalidCharacters;
        break;
      default:
        errorMessage = null;
    }
    emit(state.copyWith(
        nick: nick, status: nickStatus, errorMessage: errorMessage));
  }

  Future<void> setNickname() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _dataRepository.setNickname(nick: state.nick.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on StateError catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        errorMessage: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: "uknown error"));
    }
  }
}
