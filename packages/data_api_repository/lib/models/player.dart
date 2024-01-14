import 'package:equatable/equatable.dart';

//TODO divide models and DTOs (?)

class Player extends Equatable {
  const Player({
    this.id = '',
    required this.userId,
    required this.nick,
    required this.isLeader,
    this.character,
    this.specialCharacter,
  });

  final String id;
  final String userId;
  final String nick;
  final bool isLeader;
  final String? character; // TODO Change to boolean
  final String? specialCharacter;

  /// Empty player which represents that user is currently not in any player.
  static const empty = Player(userId: '', nick: '', isLeader: false);

  /// Convenience getter to determine whether the current player is empty.
  bool get isEmpty => this == Player.empty;

  /// Convenience getter to determine whether the current player is not empty.
  bool get isNotEmpty => this != Player.empty;

  @override
  List<Object?> get props =>
      [id, userId, nick, isLeader, character, specialCharacter];

  factory Player.fromFirestore() {
    throw UnimplementedError("This method is not implemented yet");
  }

  Map<String, dynamic> toFirestore() {
    throw UnimplementedError("This method is not implemented yet");
  }
}
