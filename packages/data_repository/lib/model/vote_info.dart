import 'package:equatable/equatable.dart';

class VoteInfo extends Equatable {
  final String voterNick;
  final bool value;

  const VoteInfo({
    required this.voterNick,
    required this.value,
  });

  @override
  List<Object?> get props => [voterNick, value];
}
