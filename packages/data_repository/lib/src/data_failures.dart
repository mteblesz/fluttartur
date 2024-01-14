String codeMessage(statusCode) =>
    statusCode != null ? ' Status Code: $statusCode' : '';

class CreateRoomFailure implements Exception {
  CreateRoomFailure([statusCode]) {
    message = "Failed to create room.${codeMessage(statusCode)}";
  }

  late String message;
}

class AddPlayerFailure implements Exception {
  CreateRoomFailure([statusCode]) {
    message = "Failed to add player.${codeMessage(statusCode)}";
  }

  late String message;
}
