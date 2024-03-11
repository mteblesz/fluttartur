import 'package:equatable/equatable.dart';

class Player extends Equatable {
  const Player({
    required this.playerId,
    required this.nick,
  });

  final int playerId;
  final String nick;

  static const empty = Player(playerId: -1, nick: '');
  bool get isEmpty => this == Player.empty;
  bool get isNotEmpty => this != Player.empty;

  @override
  List<Object?> get props => [playerId, nick];
}
