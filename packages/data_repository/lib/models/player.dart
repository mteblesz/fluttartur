import 'package:equatable/equatable.dart';

class Player extends Equatable {
  const Player({
    required this.id,
    this.nick = "NA",
  });

  final String id;
  final String nick;

  static const empty = Player(id: '');
  bool get isEmpty => this == Player.empty;
  bool get isNotEmpty => this != Player.empty;

  @override
  List<Object?> get props => [id, nick];
}
