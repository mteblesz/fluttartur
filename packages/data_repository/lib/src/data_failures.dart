abstract class DataRepoFailure implements Exception {
  DataRepoFailure(String operation, int code, [String? body]) {
    body = body ?? "Unknown error";
    message = "Failed to $operation.\n$code: $body";
  }

  late String message;
}

class CreateRoomFailure extends DataRepoFailure {
  CreateRoomFailure(int code, [String? body])
      : super("create room", code, body);
}

class JoinRoomFailure extends DataRepoFailure {
  JoinRoomFailure(int code, [String? body]) : super("join room", code, body);
}

class SetNicknameFailure extends DataRepoFailure {
  SetNicknameFailure(int code, [String? body])
      : super("set nickname", code, body);
}

class RemovePlayerFailure extends DataRepoFailure {
  RemovePlayerFailure(int code, [String? body])
      : super("remove player", code, body);
}

class StartGameFailure extends DataRepoFailure {
  StartGameFailure(int code, [String? body]) : super("start game", code, body);
}

class GetRoomFailure extends DataRepoFailure {
  GetRoomFailure(int code, [String? body])
      : super("retirieve room", code, body);
}

class GetRoleFailure extends DataRepoFailure {
  GetRoleFailure(int code, [String? body]) : super("get role", code, body);
}

class GetFilteredPlayersListFailure extends DataRepoFailure {
  GetFilteredPlayersListFailure(int code, [String? body])
      : super("start game", code, body);
}

class GetPlayersListFailure extends DataRepoFailure {
  GetPlayersListFailure(int code, [String? body])
      : super("start game", code, body);
}

class LeaveGameFailure extends DataRepoFailure {
  LeaveGameFailure(int code, [String? body]) : super("leave game", code, body);
}

class GetQuestInfoFailure extends DataRepoFailure {
  GetQuestInfoFailure(int code, [String? body])
      : super("get quest info", code, body);
}

class AddMemberFailure extends DataRepoFailure {
  AddMemberFailure(int code, [String? body]) : super("add member", code, body);
}

class RemoveMemberFailure extends DataRepoFailure {
  RemoveMemberFailure(int code, [String? body])
      : super("remove member", code, body);
}

class SubmitSquadFailure extends DataRepoFailure {
  SubmitSquadFailure(int code, [String? body])
      : super("submit squad", code, body);
}

class VoteSquadFailure extends DataRepoFailure {
  VoteSquadFailure(int code, [String? body]) : super("vote squad", code, body);
}

class VoteQuestFailure extends DataRepoFailure {
  VoteQuestFailure(int code, [String? body]) : super("vote quest", code, body);
}
