// ignore_for_file: unnecessary_null_comparison
import 'package:equatable/equatable.dart';

class Member extends Equatable {
  const Member({
    this.id = '',
    required this.playerId,
    required this.nick,
    this.vote,
  });

  final String id;
  final String playerId;
  final String nick;
  final bool? vote;

  static const empty = Member(id: '', playerId: '', nick: '');
  bool get isEmpty => this == Member.empty;
  bool get isNotEmpty => this != Member.empty;

  @override
  List<Object?> get props => [id, playerId, nick, vote];
}
