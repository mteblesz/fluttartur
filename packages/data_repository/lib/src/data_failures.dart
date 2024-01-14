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

// TODO old stuff for backwards-compatibility during changes (to be removed)

class GetRoomByIdFailure implements Exception {}

class StreamingRoomFailure implements Exception {
  const StreamingRoomFailure([this.message = 'An unknown exception occurred.']);

  final String message;
}

class StreamingPlayerFailure implements Exception {
  const StreamingPlayerFailure(
      [this.message = 'An unknown exception occurred.']);

  final String message;
}

class JoiningStartedGameFailure implements Exception {
  const JoiningStartedGameFailure(
      [this.message = 'trying to join room which has started game']);

  final String message;
}

class CharacterAndPlayersCountsDoNotMatchFailure implements Exception {
  const CharacterAndPlayersCountsDoNotMatchFailure(
      [this.message = 'lengths of list do not match']);

  final String message;
}
