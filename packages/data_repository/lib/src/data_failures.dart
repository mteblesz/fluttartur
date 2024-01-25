abstract class DataRepoFailure implements Exception {
  DataRepoFailure(String operation, int code, [String? body]) {
    body = body ?? "Unknown error";
    message = "Failed to $operation.\n$code: $body";
  }

  late String message;
}

class GetRoomFailure extends DataRepoFailure {
  GetRoomFailure(int code, [String? body])
      : super("retirieve room", code, body);
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
