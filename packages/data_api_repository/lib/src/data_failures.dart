part of 'data_api_repository.dart';

class CreateRoomFailure implements Exception {
  const CreateRoomFailure([this.message = 'An unknown exception occurred.']);

  final String message;
}
