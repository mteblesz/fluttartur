enum RoomStatus {
  unknown,
  matchup,
  playing,
  assassination,
  result,
}

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
