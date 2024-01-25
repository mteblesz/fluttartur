abstract class CRUDFailure implements Exception {
  CRUDFailure(String operation, int code, [String? body]) {
    body = body ?? "Unknown error";
    message = "Failed to $operation. ($code | $body)";
  }

  late String message;
}

abstract class ReadDataFailure extends CRUDFailure {
  ReadDataFailure(String subject, int code, [String? body])
      : super("read $subject", code, body);
}

abstract class CreateDataFailure extends CRUDFailure {
  CreateDataFailure(String subject, int code, [String? body])
      : super("create $subject", code, body);
}

abstract class UpdateDataFailure extends CRUDFailure {
  UpdateDataFailure(String operation, int code, [String? body])
      : super(operation, code, body);
}

abstract class DeleteDataFailure extends CRUDFailure {
  DeleteDataFailure(String subject, int code, [String? body])
      : super("remove $subject", code, body);
}

class GetRoomFailure extends ReadDataFailure {
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
