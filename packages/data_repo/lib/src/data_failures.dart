part of 'data_repo.dart';

class CreateRoomFailure implements Exception {
  const CreateRoomFailure([this.message = 'An unknown exception occurred.']);

  final String message;
}
