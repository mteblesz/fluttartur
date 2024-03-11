import 'package:equatable/equatable.dart';

enum Team {
  empty,
  evil,
  good,
}

enum Role {
  empty,
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

class TeamRole extends Equatable {
  final Team team;
  final Role role;

  const TeamRole(this.team, this.role);

  @override
  List<Object?> get props => [team, role];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is TeamRole) {
      return other.team == team && other.role == role;
    }
    return false;
  }

  @override
  int get hashCode => Object.hash(team, role);

  static const empty = TeamRole(Team.empty, Role.empty);
  bool get isEmpty => this == empty;
  bool get isNotEmpty => this != empty;
}

enum SquadStatus {
  unknown,
  upcoming,
  squadVoting,
  submitted,
  approved,
  rejected,
  questVoting,
  successful,
  failed,
  error,
}

enum QuestStatus {
  upcoming,
  ongoing,
  rejected,
  successful,
  failed,
  error,
}

class SquadQuestStatusMapping {
  static QuestStatus map(SquadStatus status) => _dictionary[status]!;

  static final Map<SquadStatus, QuestStatus> _dictionary = {
    SquadStatus.failed: QuestStatus.failed,
    SquadStatus.unknown: QuestStatus.error,
    SquadStatus.upcoming: QuestStatus.upcoming,
    SquadStatus.squadVoting: QuestStatus.ongoing,
    SquadStatus.submitted: QuestStatus.ongoing,
    SquadStatus.approved: QuestStatus.ongoing,
    SquadStatus.rejected: QuestStatus.rejected,
    SquadStatus.questVoting: QuestStatus.ongoing,
    SquadStatus.successful: QuestStatus.successful,
    SquadStatus.error: QuestStatus.error,
  };
}
