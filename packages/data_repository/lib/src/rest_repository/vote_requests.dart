part of 'rest_repository.dart';

extension VoteRequests on RestRepository {
  Future<void> voteSquad({required CastVoteDto dto}) async {
    final response = await HttpSender.post(
      Uri.parse(RestConfig.voteSquadUrl()),
      headers: getAuthHeaders(),
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode != 204) {
      throw VoteSquadFailure(response.statusCode, response.body);
    }
  }

  Future<void> voteQuest({required CastVoteDto dto}) async {
    final response = await HttpSender.post(
      Uri.parse(RestConfig.voteQuestUrl()),
      headers: getAuthHeaders(),
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode != 204) {
      throw VoteQuestFailure(response.statusCode, response.body);
    }
  }
}
