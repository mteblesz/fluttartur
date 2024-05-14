part of 'rest_repository.dart';

extension KillRequests on RestRepository {
  Future<void> killPlayer({required int playerId}) async {
    final response = await HttpSender.post(
      Uri.parse(RestConfig.killPlayerUrl(playerId)),
      headers: getAuthHeaders(),
    );

    if (response.statusCode != 204) {
      throw KillPlayerFailure(response.statusCode, response.body);
    }
  }
}
