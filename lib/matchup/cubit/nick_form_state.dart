part of 'nick_form_cubit.dart';

// TODO add error messages in cubits
class NickFormState extends Equatable {
  const NickFormState({
    this.nick = const Nick.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Nick nick;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [nick, status];

  NickFormState copyWith({
    Nick? nick,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return NickFormState(
      nick: nick ?? this.nick,
      status: status ?? this.status,
      errorMessage: errorMessage, // always reset errorMessage
    );
  }
}
