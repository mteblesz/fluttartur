import 'package:equatable/equatable.dart';

class Courtier extends Equatable {
  const Courtier({
    required this.id,
    required this.nick,
    this.team,
    this.role,
  });

  final String id;
  final String nick;
  final Team? team;
  final Role? role;

  static const empty = Courtier(id: '', nick: "NA");
  bool get isEmpty => this == Courtier.empty;
  bool get isNotEmpty => this != Courtier.empty;

  @override
  List<Object?> get props => [id, nick, team, role];
}

enum Team {
  evil,
  good,
}

enum Role {
  goodKnight,
  evilEntity,
  merlin,
  assassin,
  percival,
  morgana,
  mordred,
  oberon,
}

class RoleTeamMapping {
  static Team map(Role role) => _dictionary[role]!;

  static final Map<Role, Team> _dictionary = {
    Role.goodKnight: Team.good,
    Role.evilEntity: Team.evil,
    Role.merlin: Team.good,
    Role.assassin: Team.evil,
    Role.percival: Team.good,
    Role.morgana: Team.evil,
    Role.mordred: Team.evil,
    Role.oberon: Team.evil,
  };
}
