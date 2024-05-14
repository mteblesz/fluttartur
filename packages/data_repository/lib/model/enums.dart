enum RoomStatus {
  unknown,
  matchup,
  playing,
  assassination,
  resultGoodWin,
  resultEvilWin,
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

enum SquadStatus {
  unknown,
  upcoming,
  squadChoice,
  submitted,
  approved,
  rejected,
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
    SquadStatus.squadChoice: QuestStatus.ongoing,
    SquadStatus.submitted: QuestStatus.ongoing,
    SquadStatus.approved: QuestStatus.ongoing,
    SquadStatus.rejected: QuestStatus.rejected,
    SquadStatus.successful: QuestStatus.successful,
    SquadStatus.error: QuestStatus.error,
  };
}
