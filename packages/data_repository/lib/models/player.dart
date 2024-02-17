import 'package:equatable/equatable.dart';

class Player extends Equatable {
  const Player({
    required this.id,
    this.nick = "new player",
    this.team,
    this.role,
  });

  final String id;
  final String nick;
  final String? team;
  final String? role;

  static const empty = Player(id: '');
  bool get isEmpty => this == Player.empty;
  bool get isNotEmpty => this != Player.empty;

  @override
  List<Object?> get props => [id, nick, team, role];
}
