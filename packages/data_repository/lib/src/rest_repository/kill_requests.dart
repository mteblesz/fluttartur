part of 'rest_repository.dart';

extension KillRequests on RestRepository {
  Future<void> killPlayer({required KillPlayerDto dto}) async {
    final response = await HttpSender.post(
      Uri.parse(RestConfig.killPlayerUrl()),
      headers: getAuthHeaders(),
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode != 204) {
      throw KillPlayerFailure(response.statusCode, response.body);
    }
  }
}
