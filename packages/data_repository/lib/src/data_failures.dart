abstract class DataRepoFailure implements Exception {
  DataRepoFailure(String operation, int code, [String? body]) {
    body = body ?? "Unknown error";
    message = "Failed to $operation. ($code | $body)";
  }

  late String message;
}

abstract class GetDataFailure extends DataRepoFailure {
  GetDataFailure(String subject, int code, [String? body])
      : super("retrieve $subject", code, body);
}

abstract class CreateDataFailure extends DataRepoFailure {
  CreateDataFailure(String subject, int code, [String? body])
      : super("create $subject", code, body);
}

abstract class UpdateDataFailure extends DataRepoFailure {
  UpdateDataFailure(String operation, int code, [String? body])
      : super(operation, code, body);
}

abstract class DeleteDataFailure extends DataRepoFailure {
  DeleteDataFailure(String subject, int code, [String? body])
      : super("remove $subject", code, body);
}

class GetRoomFailure extends GetDataFailure {
  GetRoomFailure(int code, [String? body]) : super("room", code, body);
}

class CreateRoomFailure extends CreateDataFailure {
  CreateRoomFailure(int code, [String? body]) : super("room", code, body);
}

class JoinRoomFailure extends CreateDataFailure {
  JoinRoomFailure(int code, [String? body]) : super("player", code, body);
}

class SetNicknameFailure extends UpdateDataFailure {
  SetNicknameFailure(int code, [String? body])
      : super("set nickname", code, body);
}

class RemovePlayerFailure extends DeleteDataFailure {
  RemovePlayerFailure(int code, [String? body]) : super("player", code, body);
}
