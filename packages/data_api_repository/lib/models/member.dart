// ignore_for_file: unnecessary_null_comparison

import 'package:data_api_repository/models/models.dart';
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

  /// Empty member which represents that user is currently not in any member.
  static const empty = Member(id: '', playerId: '', nick: '');

  /// Convenience getter to determine whether the current member is empty.
  bool get isEmpty => this == Member.empty;

  /// Convenience getter to determine whether the current member is not empty.
  bool get isNotEmpty => this != Member.empty;

  @override
  List<Object?> get props => [id, playerId, nick, vote];

  factory Member.fromFirestore() {
    throw UnimplementedError("This method is not implemented yet");
  }

  Map<String, dynamic> toFirestore() {
    throw UnimplementedError("This method is not implemented yet");
  }
}
