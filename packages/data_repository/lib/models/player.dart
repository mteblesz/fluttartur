import 'package:equatable/equatable.dart';

class Player extends Equatable {
  const Player({
    required this.id,
    required this.nick,
  });

  final String id;
  final String nick;

  static const empty = Player(id: '', nick: "NA");
  bool get isEmpty => this == Player.empty;
  bool get isNotEmpty => this != Player.empty;

  @override
  List<Object?> get props => [id, nick];
}
